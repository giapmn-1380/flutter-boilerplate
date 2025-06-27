# Flutter Boilerplate

A new Flutter Boilerplate.

## Table of Contents

- [Main Technologies & Libraries](#main-technologies-and-libraries)
- [Key Features](#key-features)
- [Project Structure](#project-structure)
- [Prerequisite](#prerequisite)
  - [Setup Env file](#setup-env-file)
- [Install environment](#install-environment)
  - [Flutter SDK](#fluter-sdk)
  - [Install CocoaPods](#install-cocoapods-1152-httpscocoapodsorg)
  - [Android Studio](#android-studio-koala--202411--build-ai-24115989150241111948838-built-on-june-11-2024)
  - [XCode](#xcode-version-162-16c5032a)
- [1. Installation](#1-installation)
- [2. Run app with flavor environment](#2-run-app-with-flavor-environment)
  - [Run with command line](#run-with-command-line)
  - [Run with AndroidStudio](#run-with-androidstudio)
  - [Run with VSCode](#run-with-vscode)
- [3. Build for Dev](#3-build-for-dev)
- [4. Build for Staging](#4-build-for-staging)
- [4. Build for Production](#4-build-for-production)
- [5. [iOS] Upload to TestFlight](#5-ios-upload-to-testflight)

## Main Technologies and Libraries

- **Flutter** (>=3.4.0 <4.0.0)
- **Riverpod** (`hooks_riverpod`): Modern state management.
- **GoRouter**: Powerful navigation.
- **Dio**: HTTP client for networking.
- **Freezed & Json Serializable**: Model code generation, immutable data.
- **Easy Localization**: Multi-language support.
- **Flutter Dotenv**: Environment variable management.
- **Flutter Gen**: Auto-generate asset and SVG code.
- **Shared Preferences**: Local data storage.
- **Flutter Hooks**: UI logic and lifecycle management.
- **Flutter ScreenUtil, Breakpoint**: Responsive UI.
- **Pretty Dio Logger**: Network logging for development.

## Key Features

- **Multi-environment support**: dev, staging, production with separate `.env` files.
- **Multi-language**: Easily add/edit languages via `assets/lang/`.
- **Modern state management**: Riverpod for scalable and testable state.
- **Flexible navigation**: GoRouter with deep link and nested navigation support.
- **Automatic code generation**: Freezed, Json Serializable, Flutter Gen reduce boilerplate.
- **Centralized asset management**: Auto-generated code for assets and SVGs.
- **Flavor build support**: Build and run app for each environment.
- **Detailed setup, build, and deploy instructions**: Easy onboarding for new developers.
- **Team-friendly structure**: Standardized, maintainable, and scalable.

## Project Structure

Below is the main folder structure of this project. Each folder has a specific responsibility to keep the codebase clean and maintainable:

```
flutter-boilerplate/
├── android/              # Android native project files & configuration
├── ios/                  # iOS native project files & configuration
├── assets/               # App assets (images, SVGs, language files, etc.)
│   ├── lang/             # Localization files for multi-language support
│   └── svgs/             # SVG icon assets
├── lib/                  # Main Dart source code
│   ├── data/             # Data layer: API clients, repositories, models, error handling
│   ├── gen/              # Auto-generated code (assets, SVGs, etc. by FlutterGen)
│   ├── ui/               # UI layer: widgets, screens, themes, common components
│   ├── view_models/      # State management (Riverpod providers, logic controllers)
│   └── main.dart         # App entry point
├── docs/                 # Documentation, guides, images, and videos for onboarding
├── .env_dev              # Environment variables for development
├── .env_stag             # Environment variables for staging
├── .env_prod             # Environment variables for production
├── pubspec.yaml          # Project configuration and dependencies
└── README.md             # Project documentation
```

# Prerequisite

## Setup Env file

- Create .env_prod , .env_stag, .env_dev file on root folder and update content.
  Content .env sample:

```
BASE_URL=https://api.test
SECRET_KEY=xxxxxxx
```

# Install environment:

### Fluter SDK

Go to website:

- https://docs.flutter.dev/get-started/install

Version: 3.22.0
Example: flutter --version

```
Flutter 3.22.0 • channel stable • https://github.com/flutter/flutter.git
Framework • revision 5dcb86f68f (10 months ago) • 2024-05-09 07:39:20 -0500
Engine • revision f6344b75dc
Tools • Dart 3.4.0 • DevTools 2.34.3
```

### Install CocoaPods 1.16.2 (https://cocoapods.org/)

Please intall CocoaPods with default settings. Customized setting is not supported.

```
$ sudo gem install cocoapods -v 1.16.2
$ pod --version
```

- To remove:

```
$ sudo gem uninstall cocoapods
```

### Android Studio Koala | 2024.1.1 | Build #AI-241.15989.150.2411.11948838, built on June 11, 2024

Go to website

- https://developer.android.com/studio
- https://developer.android.com/studio/archive

#### NOTE: Java version 11 or 17
If your JAVA_HOME is set properly, you can use flutter config --jdk-dir=$JAVA_HOME to set your JAVA_HOME as the java directory for Android studio.
```
flutter config --jdk-dir=$JAVA_HOME
```
If the java path is something else, you can configure JAVA_HOME and then follow the above step OR you can run the following command:
```
flutter config --jdk-dir=PATH_TO_JAVA
```
### XCode Version 16.2 (16C5032a)

- Go to App Store on Mac OS to download.
- https://xcodereleases.com/
- Xcode 16.2 requires a Mac running macOS Sonoma 14.5 or later.

# 1. Installation

Open terminal and CD to your project folder

```
$ cd ---------/flutter-boilerplate folder
```

Install dependencies

```
$ flutter pub get
```

Select XCode #https://stackoverflow.com/questions/68565356/xcrun-error-sdk-iphoneos-cannot-be-located

```
$ sudo xcode-select --switch /Applications/Xcode.app
```

Run CocoaPods

```
$ cd ios && pod install
```

# 2. Run app with flavor environment:

### Run with command line

Dev:

```
flutter run --flavor dev --dart-define=FLAVOR=dev
```

Staging:

```
flutter run --flavor stag --dart-define=FLAVOR=stag
```

Production:

```
flutter run --flavor prod --dart-define=FLAVOR=prod
```

### Run with AndroidStudio

See video at: /docs/run_with_android_studio.mov

### Run with VSCode
At tab "RUN AND DEBUG", select environment and run.

![](/docs/run_via_vscode.png)



# 3. Build for Dev
### Preparing files

- Prepare .env_dev

### Configure

1. Edit your information on **ios/ExportOptions_dev.plist**
   Ex: Provisioning Profiles, Team ID.

2. Open pubspec.yaml to update info:
  **version: 1.0.0+1**
  In version: 1.0.0+1,
    •	1.0.0 is the VersionName (the user-facing version).
    •	1 is the VersionCode (an internal build number, which must increase with each release).

### Run to get IPA for iOS
```
	flutter clean
	flutter pub get
	flutter build ios --release --flavor dev --dart-define=FLAVOR=dev --target lib/main.dart
	flutter build ipa --release --export-options-plist=ios/ExportOptions_dev.plist --flavor dev --dart-define=FLAVOR=dev --target lib/main.dart
```
App Store app bundle (.ipa file) in **build/ios/ipa** folder.

### Run to get APK / AAB for Android
```
	flutter clean
	flutter pub get
	flutter build apk --release --flavor dev --dart-define=FLAVOR=dev --target lib/main.dart
	flutter build appbundle --flavor dev --dart-define=FLAVOR=dev --target lib/main.dart
```
.apk file in /build/app/outputs/apk folder.
.aab file in /build/app/outputs/bundle/ folder.


# 4. Build for Staging

// Same dev

# 4. Build for Production

// Same dev

# 5. [iOS] Upload to TestFlight

- Upload your app binary files with Xcode
- Upload your app binary files with altool
- Upload your app binary files with Transporter app

See at: https://developer.apple.com/help/app-store-connect/manage-builds/upload-builds
