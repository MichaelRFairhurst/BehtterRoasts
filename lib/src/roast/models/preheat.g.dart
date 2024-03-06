// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'preheat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Preheat _$$_PreheatFromJson(Map<String, dynamic> json) => _$_Preheat(
      start: DateTime.parse(json['start'] as String),
      end: Duration(microseconds: json['end'] as int),
      temp: json['temp'] as int,
    );

Map<String, dynamic> _$$_PreheatToJson(_$_Preheat instance) =>
    <String, dynamic>{
      'start': instance.start.toIso8601String(),
      'end': instance.end.inMicroseconds,
      'temp': instance.temp,
    };
