import 'package:hive/hive.dart';
import 'package:equatable/equatable.dart';
import 'base_model.dart';


part 'forecast.g.dart';

@HiveType(typeId: 1)
class Forecast extends BaseModel with EquatableMixin {
  @HiveField(0)
  final DateTime date;

  @HiveField(1)
  final double temperature;

  @HiveField(2)
  final double tempMin;

  @HiveField(3)
  final double tempMax;

  @HiveField(4)
  final String condition;

  @HiveField(5)
  final String icon;

  @HiveField(6)
  final int humidity;

  @HiveField(7)
  final double windSpeed;

  @HiveField(8)
  final double precipitation;

  Forecast({
    required this.date,
    required this.temperature,
    required this.tempMin,
    required this.tempMax,
    required this.condition,
    required this.icon,
    required this.humidity,
    required this.windSpeed,
    required this.precipitation,
  });

  factory Forecast.fromJson(Map<String, dynamic> json) {
    return Forecast(
      date: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000),
      temperature: (json['main']['temp'] as num).toDouble(),
      tempMin: (json['main']['temp_min'] as num).toDouble(),
      tempMax: (json['main']['temp_max'] as num).toDouble(),
      condition: json['weather'][0]['main'],
      icon: json['weather'][0]['icon'],
      humidity: json['main']['humidity'],
      windSpeed: (json['wind']['speed'] as num).toDouble(),
      precipitation: ((json['pop'] as num?) ?? 0) * 100,
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        'dt': date.millisecondsSinceEpoch ~/ 1000,
        'main': {
          'temp': temperature,
          'temp_min': tempMin,
          'temp_max': tempMax,
          'humidity': humidity,
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
        'pop': precipitation / 100,
      };

  @override
  List<Object?> get props => [
        date,
        temperature,
        tempMin,
        tempMax,
        condition,
        icon,
        humidity,
        windSpeed,
        precipitation,
      ];

  Forecast copyWith({
    DateTime? date,
    double? temperature,
    double? tempMin,
    double? tempMax,
    String? condition,
    String? icon,
    int? humidity,
    double? windSpeed,
    double? precipitation,
  }) {
    return Forecast(
      date: date ?? this.date,
      temperature: temperature ?? this.temperature,
      tempMin: tempMin ?? this.tempMin,
      tempMax: tempMax ?? this.tempMax,
      condition: condition ?? this.condition,
      icon: icon ?? this.icon,
      humidity: humidity ?? this.humidity,
      windSpeed: windSpeed ?? this.windSpeed,
      precipitation: precipitation ?? this.precipitation,
    );
  }
}
