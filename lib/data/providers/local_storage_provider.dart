import 'package:weatherapp/data/models/forecast.dart';
import 'package:weatherapp/data/models/weather.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

class LocalStorageProvider {
  static const String _weatherBoxName = 'weather';
  static const String _forecastBoxName = 'forecast';

  static Future<void> init() async {
    await Hive.initFlutter();

    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(WeatherAdapter());
    }
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(ForecastAdapter());
    }

    await Hive.openBox<Weather>(_weatherBoxName);
    await Hive.openBox<List<dynamic>>(_forecastBoxName);
  }

  final Box<Weather> _weatherBox = Hive.box<Weather>(_weatherBoxName);
  final Box<List<dynamic>> _forecastBox =
      Hive.box<List<dynamic>>(_forecastBoxName);

  Future<void> saveWeather(Weather weather) async {
    await _weatherBox.put(weather.cityName, weather);
  }

  Weather? getWeather(String cityName) {
    return _weatherBox.get(cityName);
  }

  List<Weather> getAllWeather() {
    return _weatherBox.values.toList();
  }

  Future<void> deleteWeather(String cityName) async {
    await _weatherBox.delete(cityName);
  }

  Future<void> clearWeather() async {
    await _weatherBox.clear();
  }

  Future<void> saveForecast(String cityName, List<Forecast> forecasts) async {
    await _forecastBox.put(cityName, forecasts);
  }

  List<Forecast>? getForecast(String cityName) {
    final data = _forecastBox.get(cityName);
    return data?.cast<Forecast>();
  }

  Future<void> deleteForecast(String cityName) async {
    await _forecastBox.delete(cityName);
  }

  Future<void> clearForecasts() async {
    await _forecastBox.clear();
  }


  Future<void> clearAll() async {
    await clearWeather();
    await clearForecasts();
  }

  bool hasData(String cityName) {
    return _weatherBox.containsKey(cityName);
  }

  DateTime? getLastUpdateTime(String cityName) {
    final weather = getWeather(cityName);
    return weather?.lastUpdated;
  }

  bool isDataStale(String cityName, Duration staleDuration) {
    final lastUpdate = getLastUpdateTime(cityName);
    if (lastUpdate == null) return true;

    final now = DateTime.now();
    return now.difference(lastUpdate) > staleDuration;
  }
}
