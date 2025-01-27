// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forecast.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ForecastAdapter extends TypeAdapter<Forecast> {
  @override
  final int typeId = 1;

  @override
  Forecast read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Forecast(
      date: fields[0] as DateTime,
      temperature: fields[1] as double,
      tempMin: fields[2] as double,
      tempMax: fields[3] as double,
      condition: fields[4] as String,
      icon: fields[5] as String,
      humidity: fields[6] as int,
      windSpeed: fields[7] as double,
      precipitation: fields[8] as double,
    );
  }

  @override
  void write(BinaryWriter writer, Forecast obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.temperature)
      ..writeByte(2)
      ..write(obj.tempMin)
      ..writeByte(3)
      ..write(obj.tempMax)
      ..writeByte(4)
      ..write(obj.condition)
      ..writeByte(5)
      ..write(obj.icon)
      ..writeByte(6)
      ..write(obj.humidity)
      ..writeByte(7)
      ..write(obj.windSpeed)
      ..writeByte(8)
      ..write(obj.precipitation);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ForecastAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
