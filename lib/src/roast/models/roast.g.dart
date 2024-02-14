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
    );

Map<String, dynamic> _$$_RoastToJson(_$_Roast instance) => <String, dynamic>{
      'beanId': instance.beanId,
      'config': instance.config.toJson(),
      'roastNumber': instance.roastNumber,
      'weightIn': instance.weightIn,
      'weightOut': instance.weightOut,
    };
