import 'package:equatable/equatable.dart';
import 'package:weatherapp/data/models/forecast.dart';
import 'package:weatherapp/data/models/weather.dart';
import '../../data/repositories/weather_repository.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
part 'weather_state.dart';
part 'weather_event.dart';

class WeatherBloc extends HydratedBloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;

  WeatherBloc({required this.weatherRepository}) : super(const WeatherState()) {
    on<FetchWeather>(_onFetchWeather);
    on<RefreshWeather>(_onRefreshWeather);
  }

  Future<void> _onFetchWeather(
    FetchWeather event,
    Emitter<WeatherState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true, error: null));

      final weather = await weatherRepository.fetch(event.city);
      final forecast = await weatherRepository.getForecast(event.city);

      final updatedCities = List<String>.from(state.searchedCities);
      if (!updatedCities.contains(event.city)) {
        if (updatedCities.length >= 5) {
          updatedCities.removeLast();
        }
        updatedCities.insert(0, event.city);
      }

      emit(state.copyWith(
        currentWeather: weather,
        forecast: forecast,
        isLoading: false,
        lastUpdated: DateTime.now().toIso8601String(),
        searchedCities: updatedCities,
      ));
    } catch (e) {
      emit(state.copyWith(
        error:
            "Run into an unexpected error. Kindly restart your device and try again.",
        isLoading: false,
      ));
    }
  }

  Future<void> _onRefreshWeather(
    RefreshWeather event,
    Emitter<WeatherState> emit,
  ) async {
    if (state.currentWeather == null) return;

    try {
      emit(state.copyWith(isLoading: true, error: null));

      final weather =
          await weatherRepository.fetch(state.currentWeather!.cityName);
      final forecast =
          await weatherRepository.getForecast(state.currentWeather!.cityName);

      emit(state.copyWith(
        currentWeather: weather,
        forecast: forecast,
        isLoading: false,
        lastUpdated: DateTime.now().toIso8601String(),
      ));
    } catch (e) {
      emit(state.copyWith(
        error: e.toString(),
        isLoading: false,
      ));
    }
  }

  @override
  WeatherState? fromJson(Map<String, dynamic> json) {
    try {
      return WeatherState(
        currentWeather: json['currentWeather'] != null
            ? Weather.fromJson(json['currentWeather'])
            : null,
        forecast: (json['forecast'] as List?)
                ?.map((e) => Forecast.fromJson(e))
                .toList() ??
            const [],
        lastUpdated: json['lastUpdated'] as String?,
        searchedCities: (json['searchedCities'] as List?)
                ?.map((e) => e as String)
                .toList() ??
            const [],
      );
    } catch (_) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(WeatherState state) {
    return {
      'currentWeather': state.currentWeather?.toJson(),
      'forecast': state.forecast.map((e) => e.toJson()).toList(),
      'lastUpdated': state.lastUpdated,
      'searchedCities': state.searchedCities,
    };
  }
}
