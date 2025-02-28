# Flutter Boilerplate

A new Flutter Boilerplate.

## Setup Env file
- Create .env_prod , .env_stag, .env_dev file on root folder and update content.
Content .env sample:
BASE_URL=https://api.test
SECRET_KEY=xxxxxxx

## Install environment: 
Flutter 3.22.0 
Example:
```
Flutter 3.22.0 • channel stable • https://github.com/flutter/flutter.git
Framework • revision 5dcb86f68f (10 months ago) • 2024-05-09 07:39:20 -0500
Engine • revision f6344b75dc
Tools • Dart 3.4.0 • DevTools 2.34.3
```

## Run app with flavor environment:
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
