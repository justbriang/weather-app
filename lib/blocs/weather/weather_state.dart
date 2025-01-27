part of 'weather_bloc.dart';

class WeatherState extends Equatable {
  final Weather? currentWeather;
  final List<Forecast> forecast;
  final String? error;
  final bool isLoading;
  final String? lastUpdated;
  final List<String> searchedCities;

  const WeatherState({
    this.currentWeather,
    this.forecast = const [],
    this.error,
    this.isLoading = false,
    this.lastUpdated,
    this.searchedCities = const [],
  });

  WeatherState copyWith({
    Weather? currentWeather,
    List<Forecast>? forecast,
    String? error,
    bool? isLoading,
    String? lastUpdated,
    List<String>? searchedCities,
  }) {
    return WeatherState(
      currentWeather: currentWeather ?? this.currentWeather,
      forecast: forecast ?? this.forecast,
      error: error,
      isLoading: isLoading ?? this.isLoading,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      searchedCities: searchedCities ?? this.searchedCities,
    );
  }

  @override
  List<Object?> get props => [
        currentWeather,
        forecast,
        error,
        isLoading,
        lastUpdated,
        searchedCities,
      ];
}
