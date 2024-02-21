// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'roast.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Roast _$$_RoastFromJson(Map<String, dynamic> json) => _$_Roast(
      beanId: json['beanId'] as String,
      config: RoastConfig.fromJson(json['config'] as Map<String, dynamic>),
      roastNumber: json['roastNumber'] as int,
      weightIn: (json['weightIn'] as num).toDouble(),
      weightOut: (json['weightOut'] as num).toDouble(),
      roasted: DateTime.parse(json['roasted'] as String),
      tempLogs: (json['tempLogs'] as List<dynamic>?)
              ?.map((e) => TempLog.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      controlLogs: (json['controlLogs'] as List<dynamic>?)
              ?.map((e) => ControlLog.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      phaseLogs: (json['phaseLogs'] as List<dynamic>?)
              ?.map((e) => PhaseLog.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$_RoastToJson(_$_Roast instance) => <String, dynamic>{
      'beanId': instance.beanId,
      'config': instance.config.toJson(),
      'roastNumber': instance.roastNumber,
      'weightIn': instance.weightIn,
      'weightOut': instance.weightOut,
      'roasted': instance.roasted.toIso8601String(),
      'tempLogs': instance.tempLogs.map((e) => e.toJson()).toList(),
      'controlLogs': instance.controlLogs.map((e) => e.toJson()).toList(),
      'phaseLogs': instance.phaseLogs.map((e) => e.toJson()).toList(),
    };
