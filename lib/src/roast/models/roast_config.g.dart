// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'roast_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_RoastConfig _$$_RoastConfigFromJson(Map<String, dynamic> json) =>
    _$_RoastConfig(
      tempInterval: json['tempInterval'] as int,
      preheatTarget: json['preheatTarget'] as int?,
      preheatTimeEst: json['preheatTimeEst'] == null
          ? null
          : Duration(microseconds: json['preheatTimeEst'] as int),
      targetDevelopment: (json['targetDevelopment'] as num).toDouble(),
    );

Map<String, dynamic> _$$_RoastConfigToJson(_$_RoastConfig instance) =>
    <String, dynamic>{
      'tempInterval': instance.tempInterval,
      'preheatTarget': instance.preheatTarget,
      'preheatTimeEst': instance.preheatTimeEst?.inMicroseconds,
      'targetDevelopment': instance.targetDevelopment,
    };
