// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'temp_log.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TempLog _$$_TempLogFromJson(Map<String, dynamic> json) => _$_TempLog(
      time: Duration(microseconds: json['time'] as int),
      temp: json['temp'] as int,
    );

Map<String, dynamic> _$$_TempLogToJson(_$_TempLog instance) =>
    <String, dynamic>{
      'time': instance.time.inMicroseconds,
      'temp': instance.temp,
    };
