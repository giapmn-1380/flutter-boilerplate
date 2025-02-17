SHELL=/bin/bash

.PHONY: $(shell egrep -oh ^[a-zA-Z0-9][a-zA-Z0-9_-]+: $(MAKEFILE_LIST) | sed 's/://')

freezed:
	flutter pub run build_runner build --delete-conflicting-outputs

br: freezed

fluttergen:
	fluttergen -c pubspec.yaml

.PHONY: build-ipa-dev
build-ipa:
	flutter clean
	flutter pub get
	flutter build ios --release --flavor dev --dart-define=FLAVOR=dev --target lib/main.dart
	flutter build ipa --release --export-options-plist=ios/ExportOptions_dev.plist --flavor dev --dart-define=FLAVOR=dev --target lib/main.dart

.PHONY: build-android-bundle-dev
build-android-bundle:
	flutter clean
	flutter pub get
	flutter build apk --release --flavor dev --dart-define=FLAVOR=dev --target lib/main.dart
	flutter build appbundle --flavor dev --dart-define=FLAVOR=dev --target lib/main.dart