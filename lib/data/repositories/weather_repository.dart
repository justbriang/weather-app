import 'dart:convert';

import 'package:weatherapp/blocs/connectivity/connectivity_bloc.dart';
import 'package:weatherapp/data/api/weather_service.dart';
import 'package:weatherapp/data/models/forecast.dart';
import 'package:weatherapp/data/models/weather.dart';
import 'package:weatherapp/data/providers/local_storage_provider.dart';
import 'package:weatherapp/utils/api_exception.dart';

import 'base_repository.dart';

class WeatherRepository implements BaseRepository<Weather> {
  final WeatherService service;
  final LocalStorageProvider storage;
  final ConnectivityBloc connectivityBloc;

  WeatherRepository({
    required this.service,
    required this.storage,
    required this.connectivityBloc,
  });

  @override
  Future<Weather> fetch(String city) async {
    if (!connectivityBloc.state.isConnected) {
      final cached = storage.getWeather(city);
      if (cached != null) return cached;
      throw ApiException(
          0, 'No internet connection - No cached data available');
    }

    try {
      final response = await service.getWeather(city);
      if (response.isSuccessful) {
        final weather = Weather.fromJson(jsonDecode(response.bodyString));
        await storage.saveWeather(weather);
        return weather;
      }

      // If API call fails, try to get cached data
      final cached = storage.getWeather(city);
      if (cached != null) return cached;

      throw ApiException(response.statusCode, response.error);
    } catch (e) {
      // For any error, try to get cached data first
      final cached = storage.getWeather(city);
      if (cached != null) return cached;

      if (e is ApiException) rethrow;
      throw ApiException(0, 'Failed to fetch weather data');
    }
  }

  Future<List<Forecast>> getForecast(String city) async {
    if (!connectivityBloc.state.isConnected) {
      final cached = storage.getForecast(city);
      if (cached != null) return cached;
      throw ApiException(
          0, 'No internet connection - No cached data available');
    }

    try {
      final response = await service.getForecast(city, 40);
      if (response.isSuccessful) {
        final forecasts = (response.body?['list'] as List)
            .map((item) => Forecast.fromJson(item))
            .where((forecast) => forecast.date.hour == 12)
            .take(5)
            .toList();
        await storage.saveForecast(city, forecasts);
        return forecasts;
      }

      // If API call fails, try to get cached data
      final cached = storage.getForecast(city);
      if (cached != null) return cached;

      throw ApiException(response.statusCode, response.error);
    } catch (e) {
      // For any error, try to get cached data first
      final cached = storage.getForecast(city);
      if (cached != null) return cached;

      if (e is ApiException) rethrow;
      throw ApiException(0, 'Failed to fetch forecast data');
    }
  }
  
  @override
  Future<void> delete(String id) {
    // TODO: implement delete
    throw UnimplementedError();
  }
  
  @override
  Future<List<Weather>> fetchAll() {
    // TODO: implement fetchAll
    throw UnimplementedError();
  }
  
  @override
  Future<void> save(Weather item) {
    // TODO: implement save
    throw UnimplementedError();
  }
  
  @override
  Future<void> update(Weather item) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
