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
git clone https://github.com/kay-af/AFRIDI-KAYAL-AnswersAi-iOS.git
cd AFRIDI-KAYAL-AnswersAi-iOS
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

- The demo video submitted shows a slight jank after loading the data in the details page. The reason for this is that the `styled_text` package used was parsing xml tags asynchronously. To counter this, I have updated the code with a very simple logic to parse **unmalformed xml** based text containing **only \<b\> tags** _(This logic does not cover cases with nested tags)_. This fixed the asynchronous loading of the text.

## Development Updates

- I have fixed the opening of the card to match the animation more as shown in the design reference. The card now grows down while opening and shrinks when closing.

- I have added a blur effect behind the card when transitioning to the next screen.

- I have improved gestures for going back to the home page from the app page, making it more seamless.