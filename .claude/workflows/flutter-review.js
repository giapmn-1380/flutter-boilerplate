export const meta = {
  name: 'flutter-review',
  description: 'Review the current diff across 5 Flutter-boilerplate dimensions, adversarially verify each finding',
  whenToUse: 'Thorough multi-agent review of a branch/PR in this repo. Pass {base: "<ref>"} as args (default: main).',
  phases: [
    { title: 'Scope', detail: 'collect changed files vs base' },
    { title: 'Review', detail: 'one reviewer per dimension' },
    { title: 'Verify', detail: 'adversarial skeptic per finding' },
  ],
}

const base = args?.base ?? 'main'

const CONVENTIONS = `Repo conventions (flutter-boilerplate):
- Data flow: Dio (dioClientProvider) -> repository (abstract interface + Impl + Provider in one file, rethrows AppException.from(e)) -> Riverpod provider (FutureProvider/Notifier) -> UI watches AsyncValue (render via AsyncValueWidget).
- Navigation only via the AppRoute enum + routerProvider redirect (lib/config/route/app_router.dart); auth changes must never navigate manually.
- User-visible strings use 'key'.tr() and the key must exist in ALL of assets/lang/en-US.json, vi-VN.json, ja-JP.json.
- Styling via lib/config/style tokens + flutter_screenutil units; assets via Assets.* (flutter_gen), never raw path strings.
- Generated files (*.freezed.dart, *.g.dart, lib/gen/**) are never hand-edited.
- Forbidden legacy patterns: c_/p_ Container-Presenter widget split, ChangeNotifier view models.`

const DIMENSIONS = [
  { key: 'bugs', focus: 'Correctness bugs only: logic errors, null-safety traps, async/await mistakes, races, BuildContext used across async gaps without mounted checks, wrong provider lifecycle (autoDispose misuse).' },
  { key: 'architecture', focus: 'Layering violations: UI importing Dio or repositories directly, business logic inside widgets, navigation bypassing the router redirect, Dio errors not mapped through AppException.' },
  { key: 'riverpod', focus: 'Riverpod misuse: ref.watch inside callbacks or ref.read inside build for reactive data, hand-rolled isLoading/error flags where AsyncValue fits, providers created inside build methods, ChangeNotifier view models.' },
  { key: 'l10n', focus: 'Localization and assets: hardcoded user-facing strings, translation keys missing from any of the three lang files (diff the key sets), raw asset paths instead of Assets.*.' },
  { key: 'hygiene', focus: 'Codegen and hygiene: hand-edited or stale generated files, hardcoded colors/sizes instead of lib/config/style tokens, dotenv read outside EnvKey, SharedPreferences accessed outside PreferenceKey.' },
]

const SCOPE_SCHEMA = {
  type: 'object',
  properties: { files: { type: 'array', items: { type: 'string' } } },
  required: ['files'],
}

const FINDINGS_SCHEMA = {
  type: 'object',
  properties: {
    findings: {
      type: 'array',
      items: {
        type: 'object',
        properties: {
          file: { type: 'string' },
          line: { type: 'number' },
          summary: { type: 'string' },
          scenario: { type: 'string' },
          severity: { type: 'string', enum: ['blocker', 'major', 'minor'] },
        },
        required: ['file', 'summary', 'scenario', 'severity'],
      },
    },
  },
  required: ['findings'],
}

const VERDICT_SCHEMA = {
  type: 'object',
  properties: {
    isReal: { type: 'boolean' },
    reason: { type: 'string' },
  },
  required: ['isReal', 'reason'],
}

const reviewPrompt = (d, files) => `You are code-reviewing changes in this Flutter repository (cwd = repo root).

${CONVENTIONS}

Files changed vs ${base} (tracked diffs and new untracked files):
${files.join('\n')}

Review ONLY through this lens: ${d.focus}

Read the actual files; use \`git diff ${base} -- <file>\` to see what changed in tracked files. Report only defects you verified by reading real code — no speculation, no style opinions outside your lens, no findings inside generated files. For each finding: repo-relative file path, line number, one-sentence summary, and a concrete failure scenario (inputs/state -> wrong behavior). An empty findings list is a valid, good answer.`

const verifyPrompt = (f) => `Adversarially verify this code-review finding in this repository by reading the actual code:

File: ${f.file}${f.line ? ':' + f.line : ''}
Claim: ${f.summary}
Scenario: ${f.scenario}

Your job is to REFUTE it. Read the file, its callers, and any related config. Check whether the scenario can genuinely occur in THIS codebase (not in theory). If you cannot confirm the defect with concrete evidence from the code, return isReal=false with the refuting reason.`

phase('Scope')
const scope = await agent(
  `In this git repository (cwd = repo root), list the source files changed vs ${base}: run \`git diff --name-only ${base}\` and \`git status --porcelain\` (to include untracked files). Return repo-relative paths. EXCLUDE: generated files (*.freezed.dart, *.g.dart, lib/gen/**), pubspec.lock, Podfile.lock, ios/Pods/**, build/**, binary assets (images, videos). KEEP: .dart, .yaml, .json, .md, gradle and plist files.`,
  { label: 'scope', schema: SCOPE_SCHEMA },
)

const files = (scope?.files ?? []).filter(Boolean)
if (!files.length) {
  return { confirmed: [], note: `No reviewable changes vs ${base}` }
}
log(`${files.length} file(s) in scope`)

const results = await pipeline(
  DIMENSIONS,
  (d) => agent(reviewPrompt(d, files), { label: `review:${d.key}`, phase: 'Review', schema: FINDINGS_SCHEMA }),
  (review, d) =>
    parallel(
      (review?.findings ?? []).map((f) => () =>
        agent(verifyPrompt(f), { label: `verify:${f.file}`, phase: 'Verify', schema: VERDICT_SCHEMA })
          .then((v) => ({ ...f, dimension: d.key, verdict: v })),
      ),
    ),
)

const judged = results.filter(Boolean).flat().filter(Boolean)
const confirmed = judged.filter((f) => f.verdict?.isReal)
const refuted = judged.filter((f) => f.verdict && !f.verdict.isReal)
// verdict null = agent verify chết (quota/lỗi) — KHÔNG được tính là refuted
const unverified = judged.filter((f) => !f.verdict)
log(`${confirmed.length} confirmed, ${refuted.length} refuted, ${unverified.length} unverified`)

return {
  base,
  filesReviewed: files.length,
  confirmed,
  refutedCount: refuted.length,
  unverified,
}
