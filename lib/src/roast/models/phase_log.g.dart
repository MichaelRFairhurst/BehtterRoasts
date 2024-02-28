// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'phase_log.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PhaseLog _$$_PhaseLogFromJson(Map<String, dynamic> json) => _$_PhaseLog(
      time: Duration(microseconds: json['time'] as int),
      phase: $enumDecode(_$PhaseEnumMap, json['phase']),
    );

Map<String, dynamic> _$$_PhaseLogToJson(_$_PhaseLog instance) =>
    <String, dynamic>{
      'time': instance.time.inMicroseconds,
      'phase': _$PhaseEnumMap[instance.phase]!,
    };

const _$PhaseEnumMap = {
  Phase.dryEnd: 'dryEnd',
  Phase.firstCrack: 'firstCrack',
  Phase.secondCrack: 'secondCrack',
  Phase.done: 'done',
};
