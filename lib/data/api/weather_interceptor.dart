import 'package:chopper/chopper.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class WeatherApiInterceptor implements Interceptor {
  final String apiKey;

  WeatherApiInterceptor(this.apiKey);

  @override
  Future<Response<BodyType>> intercept<BodyType>(Chain<BodyType> chain) async {
    final originalRequest = chain.request;
    final updatedUri = originalRequest.uri.replace(
      queryParameters: {
        ...originalRequest.uri.queryParameters,
        'appid': dotenv.env['WEATHER_API_KEY'] ?? '',
        'units': 'metric',
      },
    );

    final modifiedRequest = originalRequest.copyWith(uri: updatedUri);
    return chain.proceed(modifiedRequest);
  }
}
