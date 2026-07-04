# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project overview

A Flutter boilerplate app (Flutter >=3.4.0 <4.0.0, Dart >=3.4.0) with Riverpod state
management, GoRouter navigation (Auth stack + Main stack with bottom navigation), flavor-based
environments, and code generation for models/assets. This is a template repo — auth is faked
via SharedPreferences and the Posts tab demos a real API call (jsonplaceholder.typicode.com).

## Commands

### Setup
```
flutter pub get
cd ios && pod install
```
Requires `.env_dev`, `.env_stag`, `.env_prod` files at the repo root (gitignored) with
`BASE_URL` and `SECRET_KEY` keys. For the Posts demo to work, `BASE_URL` must be
`https://jsonplaceholder.typicode.com`.

### Run (flavor is required — the app reads `FLAVOR` via `--dart-define` to pick which `.env_*` file to load)
```
flutter run --flavor dev  --dart-define=FLAVOR=dev
flutter run --flavor stag --dart-define=FLAVOR=stag
flutter run --flavor prod --dart-define=FLAVOR=prod
```
VSCode: use the "RUN AND DEBUG" tab (configs in `.vscode/launch.json`).

### Code generation
```
make freezed      # flutter pub run build_runner build --delete-conflicting-outputs (freezed + json_serializable)
make br            # alias for `make freezed`
make fluttergen    # regenerate lib/gen/assets.gen.dart from assets declared in pubspec.yaml
```
Run `make freezed` after adding/editing any `@freezed` model. Run `make fluttergen` after
adding assets under `assets/image/` or `assets/svgs/`.

### Lint / analyze / test
```
flutter analyze
flutter test
flutter test test/data/models/post_test.dart   # single test file
```
Lint rules: `package:flutter_lints/flutter.yaml` plus `custom_lint` / `riverpod_lint` rules in
`analysis_options.yaml`. Generated files (`**/*.g.dart`, `**/*.freezed.dart`) are excluded.

### Release builds
```
flutter build ipa --release --build-name=<version> --build-number=<build> \
  --export-options-plist=ios/ExportOptions_dev.plist --flavor dev --dart-define=FLAVOR=dev --target lib/main.dart
flutter build apk --release --build-name=<version> --build-number=<build> --flavor dev --dart-define=FLAVOR=dev --target lib/main.dart
flutter build appbundle --build-name=<version> --build-number=<build> --flavor dev --dart-define=FLAVOR=dev --target lib/main.dart
```
Swap `dev` for `stag`/`prod` and use the matching `ios/ExportOptions_*.plist`. Bump `version:`
in `pubspec.yaml` before release builds — see README.md for TestFlight/provisioning details.

## Architecture

### Layering
Data flows: repository (Dio call, throws `AppException`) → provider/notifier (Riverpod,
exposes `AsyncValue` or state) → UI (watches provider). Each layer:
- `lib/data/repositories/` — abstract interface + `*Impl` per domain, exposed via a Riverpod
  `Provider` in the same file (e.g. `postRepositoryProvider`, `authRepositoryProvider`).
  Repositories catch `DioException` and rethrow as `AppException.from(e)`.
- `lib/data/app_error.dart` — `AppException` with `AppErrorType` enum (network, timeout,
  badRequest, unauthorized, server, cancel, unknown); `AppException.fromDioException` maps
  Dio errors/status codes to types.
- `lib/data/remote/dio_client.dart` — `dioClientProvider` builds Dio with `BASE_URL` from env,
  timeouts, auth-header interceptor stub, and PrettyDioLogger in debug.
- `lib/view_models/` — Riverpod providers/notifiers. `AuthController`
  (`Notifier<AuthStatus>`) owns login/register/logout and session restore; data fetching uses
  `FutureProvider` (e.g. `postsProvider`) so UI gets `AsyncValue` for free.

### Routing: Auth stack vs Main stack
`lib/config/route/app_router.dart` is the single source of truth:
- `AppRoute` enum holds all paths.
- `routerProvider` (`Provider<GoRouter>`) bridges `authControllerProvider` into a
  `ValueNotifier` used as `refreshListenable`, and a top-level `redirect` enforces the stacks:
  `AuthStatus.unknown` → splash, `unauthenticated` → login/register only,
  `authenticated` → main stack (any splash/auth location bounces to `/home`).
- Auth stack: `/login`, `/register` (plain `GoRoute`s; register is pushed from login).
- Main stack: `StatefulShellRoute.indexedStack` with 4 branches (`/home`, `/posts`,
  `/settings`, `/profile`), each tab keeping its own navigation state. `MainScreen` renders
  the `StatefulNavigationShell` + Material 3 `NavigationBar`.

Adding a screen: add the path to `AppRoute`, then a `GoRoute` (top-level for full-screen, or
inside a branch for a tab sub-route). Never navigate manually on auth changes — update
`AuthController` state and let the redirect handle it (see login/logout flows).

### Auth flow (fake)
`AuthRepositoryImpl` simulates a backend (800ms delay, persists `PreferenceKey.hasLogin` in
SharedPreferences). `AuthController.build()` restores the session asynchronously; splash shows
while status is `unknown`. To integrate a real backend, only `AuthRepositoryImpl` should
change.

### UI conventions
No Container/Presenter (`c_`/`p_`) split. Screens live in `lib/ui/screens/<feature>/` and are
`ConsumerWidget`/`HookConsumerWidget` when they need Riverpod/hooks, plain `StatelessWidget`
otherwise. Reusable widgets go in `lib/ui/widgets/common/`:
- `AsyncValueWidget<T>` — renders an `AsyncValue` with default loading (spinner) and error
  (localized message + retry) states; use it for any provider-backed screen (see `PostsTab`).
- `AppTextField`, `PrimaryButton` (with `isLoading`), `showAlertDialog` (confirm/error
  dialogs), `PrimaryProgressIndicator`.
- Form validation via `lib/utils/validators.dart` (localized messages).

### Environment / flavors
`lib/utils/constants.dart` reads the `FLAVOR` dart-define (`Flavor.dev/stag/prod`, default
`dev`) and loads `.env_<flavor>` via `flutter_dotenv` in `loadEnvironmentOfFlavor()` (called
from `main()` before `runApp`). `Constants.shared()` exposes typed env values via `EnvKey`
(`lib/data/local/env_key.dart`) — add new env vars there rather than reading `dotenv` directly.

### Styling & localization
`lib/config/style/` holds design tokens (`CustomColor`, `CustomTextStyle`, `CustomSpacing`,
`CustomShape`, `CustomBreakPoint`) — use these instead of hardcoded values.
`flutter_screenutil` is initialized with `designSize: Size(375, 734)`.
Localization: `easy_localization` with `assets/lang/{en-US,ja-JP,vi-VN}.json` (`en-US`
fallback). Use `'key'.tr()`; add new keys to all three files together. The language switcher
lives in `SettingsTab`.

### Models & codegen
Models under `lib/data/models/<domain>/` use `freezed` + `json_serializable` — always run
`make freezed` after editing; never hand-edit `.freezed.dart`/`.g.dart`. Asset access goes
through `flutter_gen` (`Assets.image.*`, `Assets.svgs.*`) — regenerate via `make fluttergen`
instead of hardcoding asset paths.
