# Weather App(Flutter)

A weather application that provides current weather information and 5-day forecasts with offline support.

## Features

- **Current Weather Display**: View detailed current weather information including temperature, conditions, humidity, and wind speed
- **5-Day Forecast**: Access a 5-day weather forecast for your selected city
- **City Search**: Search for weather information in any city worldwide
- **Offline Support**: Access previously loaded weather data even without an internet connection
- **Auto-Refresh**: Weather data automatically updates to ensure accuracy
- **Cached Cities**: Quick access to recently searched cities
- **Material Design**: Clean and modern user interface following Material Design principles
- **Dark Mode Support**: Automatic theme switching based on system preferences

## Technical Features

- **BLoC Pattern**: State management using Flutter BLoC for clean architecture
- **API Integration**: Weather data fetched from OpenWeather API
- **Local Storage**: Offline data persistence using Hive
- **Connectivity Handling**: Automatic handling of online/offline states
- **Error Handling**: Comprehensive error handling with user-friendly messages
- **Hydrated BLoC**: Persistent state management
- **Responsive Design**: Adapts to different screen sizes

## Getting Started

### Prerequisites

- Flutter SDK (latest version)
- Dart SDK (latest version)
- OpenWeather API key

### Installation

1. Clone the repository:
```bash
git clone https://github.com/yourusername/weather_app.git
```

2. Navigate to the project directory:
```bash
cd weather_app
```

3. Install dependencies:
```bash
flutter pub get
```
4. Copy `.env.example` to `.env`

5. Replace `your_api_key_here` with your actual OpenWeather API key


6. Run the app:
```bash
flutter run
```

## Project Structure

```
lib/
├── blocs/                 # BLoC state management
│   ├── connectivity/      # Network connectivity management
│   └── weather/          # Weather data management
├── data/
│   ├── api/              # API services
│   ├── models/           # Data models
│   ├── providers/        # Local storage providers
│   └── repositories/     # Data repositories
└── ui/
    ├── screens/          # App screens
    └── widgets/          # Reusable widgets
```

## Dependencies

- `flutter_bloc`: State management
- `hydrated_bloc`: Persistent state management
- `connectivity_plus`: Network connectivity detection
- `hive`: Local data storage
- `chopper`: API client
- `equatable`: Value equality
- `intl`: Internationalization and formatting
- `flex_color_scheme`: Theming

