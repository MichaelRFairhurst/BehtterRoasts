// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'control_log.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ControlLog _$$_ControlLogFromJson(Map<String, dynamic> json) =>
    _$_ControlLog(
      time: Duration(microseconds: json['time'] as int),
      control: $enumDecode(_$ControlEnumMap, json['control']),
    );

Map<String, dynamic> _$$_ControlLogToJson(_$_ControlLog instance) =>
    <String, dynamic>{
      'time': instance.time.inMicroseconds,
      'control': _$ControlEnumMap[instance.control]!,
    };

const _$ControlEnumMap = {
  Control.p1: 'p1',
  Control.p2: 'p2',
  Control.p3: 'p3',
  Control.p4: 'p4',
  Control.p5: 'p5',
  Control.d: 'd',
};
