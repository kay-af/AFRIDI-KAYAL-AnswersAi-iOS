# Store

Answers AI - iOS Store app

## Requirements

Ensure the following are installed and configured before running the app:

- [Flutter SDK](https://flutter.dev/docs/get-started/install) (Tested with 3.24.5 - Stable)
- Dart (included with Flutter)
- Xcode (for iOS development)
- An iOS Simulator / A physical device (Signing is required for it)

## Steps to run the App

### 1. Clone the Repository

Clone this repository to your local machine:

```bash
git clone <repository-url>
cd <project-directory>
```

### 2. Fetch Dependencies & Run build runner

Run the following command to download the necessary packages:

```bash
flutter pub get
```

Run the following command to run the build runner and generate required code to run the application:

```bash
dart run build_runner build
```

### 3. Start an iOS Simulator

Open Xcode and start a simulator. (Tested with **iPhone 16 Pro Max** running on **iOS 18.1**)

### 4. Run the App

Use the following command to build and run the app:

```
flutter run
```

## Development notes

- State Management: `flutter_riverpod` was chosen for state management due to its simplicity, and reusability. It is an alternative to Provider and eliminates boilerplate.

- Data Class & Serialization: `freezed` is used to create immutable data classes. `json_serializable` is used for JSON parsing.

- Feature-based segregation is used to ensure the project structure is modular, maintainable, and scalable.

- APIs are mocked within the codebase.

- Tools like `build_runner` and `freezed` allow auto-generating repetitive code (e.g., models, serialization).

- For replicating the share functinality, `share_plus` package is used.

- Animations are done using flutter's inbuilt features. No external libraries are used.