# GateLog - OneStop App (Flutter Package)

GateLog is a Flutter package developed for the OneStop App at IIT Guwahati. It facilitates the digital recording of student entry and exit times at campus gates, replacing the traditional manual register system. The package integrates seamlessly with the OneStop app and is imported using the `pubspec.yaml` file.

## Features

- **Digital Gate Logging**: Allows students to log their check-ins and check-outs at campus gates.
- **Real-time Data**: Logs are instantly updated and can be tracked in real-time.
- **Firebase Integration**: Uses Firestore for secure storage of logs and Firebase Authentication for user authentication.
- **User Notifications**: Provides real-time notifications upon successful check-ins and check-outs.
- **Increased Engagement**: GateLog has significantly boosted app usage with more active users.

## Tech Stack

- **Framework**: Flutter
- **Backend**: Node.js

## Installation

To install the GateLog package in your Flutter app, follow these steps:

### 1. Add to `pubspec.yaml`

In the `pubspec.yaml` file of your Flutter project, add the following dependency:

```yaml
dependencies:
  gate_log:
    git:
      url: https://github.com/swciitg/gatelog_onestop.git
      path: packages/gate_log
```
Then run:

```bash
flutter pub get
```

### 3. Usage

Import the GateLog package in your Dart files:

```dart
import 'package:gate_log/gate_log.dart';
```

## Contributing

We welcome contributions to enhance the functionality of the GateLog package. To contribute:

1. Fork this repository.
2. Create a new branch for your feature or bug fix.
3. Submit a pull request.
