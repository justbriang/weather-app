import 'package:hive/hive.dart';
import 'package:equatable/equatable.dart';
import 'base_model.dart';

part 'weather.g.dart';

@HiveType(typeId: 0)
class Weather extends BaseModel with EquatableMixin {
  @HiveField(0)
  final String cityName;

  @HiveField(1)
  final double temperature;

  @HiveField(2)
  final String condition;

  @HiveField(3)
  final String icon;

  @HiveField(4)
  final double humidity;

  @HiveField(5)
  final double windSpeed;

  @HiveField(6)
  final DateTime lastUpdated;

  @HiveField(7)
  final double feelsLike;

  @HiveField(8)
  final double tempMin;

  @HiveField(9)
  final double tempMax;

  @HiveField(10)
  final int pressure;

  @HiveField(11)
  final int visibility;

  Weather({
    required this.cityName,
    required this.temperature,
    required this.condition,
    required this.icon,
    required this.humidity,
    required this.windSpeed,
    required this.lastUpdated,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.visibility,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'],
      temperature: (json['main']['temp'] as num).toDouble(),
      condition: json['weather'][0]['main'],
      icon: json['weather'][0]['icon'],
      humidity: (json['main']['humidity'] as num).toDouble(),
      windSpeed: (json['wind']['speed'] as num).toDouble(),
      lastUpdated: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000),
      feelsLike: (json['main']['feels_like'] as num).toDouble(),
      tempMin: (json['main']['temp_min'] as num).toDouble(),
      tempMax: (json['main']['temp_max'] as num).toDouble(),
      pressure: json['main']['pressure'],
      visibility: json['visibility'],
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        'name': cityName,
        'main': {
          'temp': temperature,
          'humidity': humidity,
          'feels_like': feelsLike,
          'temp_min': tempMin,
          'temp_max': tempMax,
          'pressure': pressure,
        },
        'weather': [
          {
            'main': condition,
            'icon': icon,
          }
        ],
        'wind': {
          'speed': windSpeed,
        },
        'dt': lastUpdated.millisecondsSinceEpoch ~/ 1000,
        'visibility': visibility,
      };

  @override
  List<Object?> get props => [
        cityName,
        temperature,
        condition,
        icon,
        humidity,
        windSpeed,
        lastUpdated,
        feelsLike,
        tempMin,
        tempMax,
        pressure,
        visibility,
      ];

  Weather copyWith({
    String? cityName,
    double? temperature,
    String? condition,
    String? icon,
    double? humidity,
    double? windSpeed,
    DateTime? lastUpdated,
    double? feelsLike,
    double? tempMin,
    double? tempMax,
    int? pressure,
    int? visibility,
  }) {
    return Weather(
      cityName: cityName ?? this.cityName,
      temperature: temperature ?? this.temperature,
      condition: condition ?? this.condition,
      icon: icon ?? this.icon,
      humidity: humidity ?? this.humidity,
      windSpeed: windSpeed ?? this.windSpeed,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      feelsLike: feelsLike ?? this.feelsLike,
      tempMin: tempMin ?? this.tempMin,
      tempMax: tempMax ?? this.tempMax,
      pressure: pressure ?? this.pressure,
      visibility: visibility ?? this.visibility,
    );
  }
}
