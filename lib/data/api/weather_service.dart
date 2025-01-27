import 'package:chopper/chopper.dart';
import 'package:weatherapp/data/api/weather_interceptor.dart';

part 'weather_service.chopper.dart';

@ChopperApi(baseUrl: '/data/2.5')
abstract class WeatherService extends ChopperService {
  static WeatherService create([ChopperClient? client]) =>
      _$WeatherService(client ??
          ChopperClient(
            baseUrl: Uri.parse('https://api.openweathermap.org'),
            interceptors: [
              HttpLoggingInterceptor(),
              WeatherApiInterceptor(
                  const String.fromEnvironment('WEATHER_API_KEY')),
            ],
            converter: JsonConverter(),
          ));

  @Get(path: '/weather')
  Future<Response<Map<String, dynamic>>> getWeather(@Query('q') String city);

  @Get(path: '/forecast')
  Future<Response<Map<String, dynamic>>> getForecast(
    @Query('q') String city,
    @Query('cnt') int count,
  );
}
