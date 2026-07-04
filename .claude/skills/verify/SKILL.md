---
name: verify
description: Verify changes in this Flutter boilerplate end-to-end — regenerate code if models changed, then run analyzer, custom_lint (Riverpod rules), and tests. Use before committing or reporting a change as done.
---

# Verify Flutter boilerplate changes

Run the gates in this order; stop and fix at the first failure.

## 1. Codegen (only if freezed/json models or assets changed)

```bash
make freezed        # if lib/data/models/** changed
make fluttergen     # if assets/image/** or assets/svgs/** changed
```

A dirty `git status` on `*.freezed.dart`/`*.g.dart`/`assets.gen.dart` after running means the generated files were stale — include them in the change.

## 2. Static analysis

```bash
flutter analyze                # must report "No issues found!"
dart run custom_lint           # Riverpod lint rules from analysis_options.yaml
```

`custom_lint` is slower and noisier — run it when providers/notifiers changed.

## 3. Tests

```bash
flutter test
```

## 4. Runtime check (UI changes only)

Analyze + tests do not prove a screen renders. If the change touches UI/navigation and a device or simulator is available:

```bash
flutter devices
flutter run --flavor dev --dart-define=FLAVOR=dev -d <device_id>
```

Drive the affected flow (e.g. login → tab → screen). Auth accepts any valid-format email + password ≥ 6 chars. If no device is available, state plainly that runtime verification was skipped.

## 5. Localization consistency (if lang keys changed)

The key sets of `assets/lang/en-US.json`, `vi-VN.json`, `ja-JP.json` must be identical:

```bash
for f in assets/lang/*.json; do python3 -c "import json,sys; print(sorted(json.load(open('$f')).keys()))" ; done | uniq -c
```

One unique line = in sync. Report each gate's result honestly — a skipped gate is reported as skipped, not passed.
