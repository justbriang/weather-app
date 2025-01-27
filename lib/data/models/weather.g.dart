// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WeatherAdapter extends TypeAdapter<Weather> {
  @override
  final int typeId = 0;

  @override
  Weather read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Weather(
      cityName: fields[0] as String,
      temperature: fields[1] as double,
      condition: fields[2] as String,
      icon: fields[3] as String,
      humidity: fields[4] as double,
      windSpeed: fields[5] as double,
      lastUpdated: fields[6] as DateTime,
      feelsLike: fields[7] as double,
      tempMin: fields[8] as double,
      tempMax: fields[9] as double,
      pressure: fields[10] as int,
      visibility: fields[11] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Weather obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.cityName)
      ..writeByte(1)
      ..write(obj.temperature)
      ..writeByte(2)
      ..write(obj.condition)
      ..writeByte(3)
      ..write(obj.icon)
      ..writeByte(4)
      ..write(obj.humidity)
      ..writeByte(5)
      ..write(obj.windSpeed)
      ..writeByte(6)
      ..write(obj.lastUpdated)
      ..writeByte(7)
      ..write(obj.feelsLike)
      ..writeByte(8)
      ..write(obj.tempMin)
      ..writeByte(9)
      ..write(obj.tempMax)
      ..writeByte(10)
      ..write(obj.pressure)
      ..writeByte(11)
      ..write(obj.visibility);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WeatherAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
