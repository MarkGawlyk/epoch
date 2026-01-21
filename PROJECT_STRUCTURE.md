# Epoch Flutter Project Structure

This is a standard Flutter application project structure.

## Project Overview

- **Name**: Epoch
- **Description**: A new Flutter project (placeholder app)
- **Package**: com.example.epoch

## Directory Structure

```
epoch/
├── lib/                    # Main Dart source code
│   └── main.dart          # Entry point for the app
├── android/               # Android platform-specific code
├── ios/                   # iOS platform-specific code
├── web/                   # Web platform-specific code
├── test/                  # Unit and widget tests
├── pubspec.yaml          # Project dependencies and metadata
├── analysis_options.yaml # Dart analyzer configuration
└── README.md             # Project documentation
```

## Key Files

### Main Application
- `lib/main.dart`: Contains the main Flutter app with a simple counter demo

### Configuration
- `pubspec.yaml`: Defines project metadata, dependencies (Flutter SDK, Material icons, etc.)
- `analysis_options.yaml`: Linting rules for code quality

### Platform Support
- Android: Configured with Gradle build system, Kotlin support
- iOS: Swift-based configuration with Info.plist
- Web: HTML5 web app with manifest

## Running the App

To run this Flutter app, you'll need:
1. Flutter SDK installed (https://docs.flutter.dev/get-started/install)
2. An IDE (VS Code, Android Studio, or IntelliJ)
3. Connected device or emulator

Then run:
```bash
flutter pub get      # Install dependencies
flutter run          # Run the app
flutter test         # Run tests
```

## Next Steps

This is a placeholder Flutter app with the standard counter demo. You can now:
- Modify `lib/main.dart` to implement your app features
- Add new screens and widgets
- Install additional packages via `pubspec.yaml`
- Build for specific platforms (Android, iOS, Web)
