# Battery Tracker App

This Flutter application tracks the device's battery level and charging status using platform-specific functionality via Method Channels. It is compatible with iOS and Android platforms and includes error handling, a clean UI, and animations for a smooth user experience.

## Features

- **Retrieve Battery Info**: Get the current battery level and charging status using native platform calls.
- **Refresh Button**: The app includes a button to refresh the battery info.
- **Method Channel Implementation**: Native functionality is handled using Flutter's Method Channels (no third-party battery packages).
- **Cross-platform**: The app runs on Android and iOS devices.

## Screenshots

<p align="center">
  <img src="https://github.com/user-attachments/assets/4edea7f6-29b4-459d-bf6e-a0f470630e96" alt="Screenshot 1" width="300"/>
  <img src="https://github.com/user-attachments/assets/1313f95c-8ab7-4cb5-a6ec-016f9eadb17b" alt="Screenshot 2" width="300"/>
  <img src="https://github.com/user-attachments/assets/a7dc29cd-5e04-4687-a46e-1914e4914aa1" alt="Screenshot 2" width="300"/>
</p>



## Requirements

- **Flutter**: Ensure you have Flutter installed. You can get Flutter from [here](https://flutter.dev).
- **Real iOS Device**: For iOS, you need to run the app on a real device and have a valid Apple developer account.
  - The current bundle ID is `com.rahen.finance`. If you want to run the app on your IOS Device change the bundle ID in `ios/Runner.xcodeproj` to match your Apple developer account.

## How to Run

1. Clone the repository:

   ```bash
   git clone https://github.com/abdullah-19-8/battery_tracker.git
   cd battery_tracker
   ```

2. Install the dependencies:

   ```bash
   flutter pub get
   ```

3. For Android, connect an Android device or start an Android emulator:

   ```bash
   flutter run
   ```

4. For iOS:
   
  - Connect a real iOS device.
  - Open the project in Xcode by navigating to ios/Runner.xcworkspace.
  - Change the bundle identifier if necessary.
  - Run the app from Xcode or the terminal:
    
   ```bash
   flutter run
   ```

## Method Channel Implementation
The battery level and charging status are retrieved via native platform calls using Method Channels. 
The implementation is structured as follows:

  - Android: Kotlin code interacts with the Android battery APIs.
  - iOS: Swift code retrieves battery information from the iOS device.


## Error Handling
  - Proper error messages are displayed in the UI if there's any issue retrieving battery info or charging status.

## State Management
  - The app uses Riverpod for managing the state and handling the logic for refreshing battery data.

## Architecture

The app follows a clean architecture approach with three main layers:

  1. Presentation: UI and state management.
  2. Domain: Business logic (e.g., use cases for retrieving battery info).
  3. Data: Platform-specific data retrieval (using Method Channels).

## Future Improvements

  - Add more animations and improve UI design.
  - Add unit and widget tests for better test coverage.


