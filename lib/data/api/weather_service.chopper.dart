// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$WeatherService extends WeatherService {
  _$WeatherService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = WeatherService;

  @override
  Future<Response<Map<String, dynamic>>> getWeather(String city) {
    final Uri $url = Uri.parse('/data/2.5/weather');
    final Map<String, dynamic> $params = <String, dynamic>{'q': city};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<Map<String, dynamic>, Map<String, dynamic>>($request);
  }

  @override
  Future<Response<Map<String, dynamic>>> getForecast(
    String city,
    int count,
  ) {
    final Uri $url = Uri.parse('/data/2.5/forecast');
    final Map<String, dynamic> $params = <String, dynamic>{
      'q': city,
      'cnt': count,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<Map<String, dynamic>, Map<String, dynamic>>($request);
  }
}
