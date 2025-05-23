# Travel Diary

A cross-platform travel diary application built with Flutter, featuring offline support, user authentication, and multi-language support.

## Features

- Firebase Email/Password login, registration, and guest mode
- Offline mode with data synchronization
- Multi-language support (English, Spanish, French)
- Theme customization (Light, Dark, System)
- Trip management with images
- Profile customization
- Responsive design for both portrait and landscape modes

## Getting Started

### Prerequisites

- Flutter SDK (^3.0.0)
- Dart SDK (^3.0.0)
- Firebase project

### Setup

1. Clone the repository:
```bash
git clone https://github.com/yourusername/travel_diary.git
cd travel_diary
```

2. Install dependencies:
```bash
flutter pub get
```

3. Configure Firebase:
   - Create a new Firebase project at [Firebase Console](https://console.firebase.google.com/)
   - Enable Email/Password authentication
   - Add your Android and iOS apps to the project
   - Download and replace the Firebase configuration files:
     - Android: `android/app/google-services.json`
     - iOS: `ios/Runner/GoogleService-Info.plist`
   - Update `lib/firebase_options.dart` with your Firebase configuration

4. Run the app:
```bash
flutter run
```

## Project Structure

```
lib/
  ├── l10n/                  # Localization files
  ├── models/               # Data models
  ├── screens/             # UI screens
  ├── services/            # Business logic and services
  ├── firebase_options.dart # Firebase configuration
  └── main.dart            # Application entry point
```

## Features in Detail

### Authentication
- Email/Password login and registration
- Guest mode with limited access
- Persistent login session

### Offline Support
- Local data storage using SQLite
- Automatic synchronization when online
- Clear offline mode indicator

### User Interface
- Material Design 3
- Responsive layout
- Portrait and landscape support
- Bottom navigation
- FAB for adding trips

### Data Management
- Create, read, update, delete trips
- Image upload support
- Offline data persistence
- Cloud synchronization

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
