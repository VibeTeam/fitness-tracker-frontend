# Flutter Project Setup Guide

## 1. Clone the Repository

```sh
git clone <YOUR_REPOSITORY_URL>
cd <YOUR_PROJECT_FOLDER>
```

## 2. Install Flutter SDK

- Follow the official guide: https://docs.flutter.dev/get-started/install
- Check your installation:

```sh
flutter doctor
```

## 3. Install Dependencies

```sh
flutter pub get
```

## 4. Run the App

### iOS

- Requires macOS and Xcode
- Start a simulator or connect a real device

```sh
flutter run
```

### Android

- Install Android Studio and set up an emulator or connect a device

```sh
flutter run
```

### Web

- Use Chrome or another supported browser

```sh
flutter run -d chrome
```

### Desktop (macOS, Windows, Linux)

- Enable the desired platform support:

```sh
flutter config --enable-macos-desktop
flutter config --enable-windows-desktop
flutter config --enable-linux-desktop
```

- Run:

```sh
flutter run -d macos
flutter run -d windows
flutter run -d linux
```

## 5. Build Release Version

- iOS: `flutter build ios --release`
- Android: `flutter build apk --release`
- Web: `flutter build web`
- Desktop: `flutter build macos` / `flutter build windows` / `flutter build linux`

## 6. Troubleshooting

- If you have CocoaPods issues (iOS):

```sh
cd ios
pod install
cd ..
```

- If your device is not detected, make sure it is selected and trusted by your computer.
- For Android: ensure Developer Mode and USB debugging are enabled.

---

**Flutter Documentation:**  
https://docs.flutter.dev/get-started/install
