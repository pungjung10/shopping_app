# shopping_app

### Prerequisites
Make sure you have the following installed:
- Flutter SDK
- Android Studio or VS Code (with Flutter and Dart plugins)
- An emulator (Android or iOS)

### Dependencies
Run the following command to install the project dependencies:

```bash
flutter pub get
```

### Generating Retrofit Dio Code
Run the following command to generate retrofit Dio code:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### Base URL Configuration
- Android Emulator: If you're running the app on an Android Emulator, use the following base URL for API calls:
  http://10.0.2.2:8080
- iOS Simulator: If you're running the app on the iOS Simulator, use the following base URL for API calls:
  http://localhost:8080
