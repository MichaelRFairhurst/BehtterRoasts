// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'roast_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

RoastConfig _$RoastConfigFromJson(Map<String, dynamic> json) {
  return _RoastConfig.fromJson(json);
}

/// @nodoc
mixin _$RoastConfig {
  int get tempInterval => throw _privateConstructorUsedError;
  int? get preheatTarget => throw _privateConstructorUsedError;
  Duration? get preheatTimeEst => throw _privateConstructorUsedError;
  double get targetDevelopment => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RoastConfigCopyWith<RoastConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RoastConfigCopyWith<$Res> {
  factory $RoastConfigCopyWith(
          RoastConfig value, $Res Function(RoastConfig) then) =
      _$RoastConfigCopyWithImpl<$Res, RoastConfig>;
  @useResult
  $Res call(
      {int tempInterval,
      int? preheatTarget,
      Duration? preheatTimeEst,
      double targetDevelopment});
}

/// @nodoc
class _$RoastConfigCopyWithImpl<$Res, $Val extends RoastConfig>
    implements $RoastConfigCopyWith<$Res> {
  _$RoastConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tempInterval = null,
    Object? preheatTarget = freezed,
    Object? preheatTimeEst = freezed,
    Object? targetDevelopment = null,
  }) {
    return _then(_value.copyWith(
      tempInterval: null == tempInterval
          ? _value.tempInterval
          : tempInterval // ignore: cast_nullable_to_non_nullable
              as int,
      preheatTarget: freezed == preheatTarget
          ? _value.preheatTarget
          : preheatTarget // ignore: cast_nullable_to_non_nullable
              as int?,
      preheatTimeEst: freezed == preheatTimeEst
          ? _value.preheatTimeEst
          : preheatTimeEst // ignore: cast_nullable_to_non_nullable
              as Duration?,
      targetDevelopment: null == targetDevelopment
          ? _value.targetDevelopment
          : targetDevelopment // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_RoastConfigCopyWith<$Res>
    implements $RoastConfigCopyWith<$Res> {
  factory _$$_RoastConfigCopyWith(
          _$_RoastConfig value, $Res Function(_$_RoastConfig) then) =
      __$$_RoastConfigCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int tempInterval,
      int? preheatTarget,
      Duration? preheatTimeEst,
      double targetDevelopment});
}

/// @nodoc
class __$$_RoastConfigCopyWithImpl<$Res>
    extends _$RoastConfigCopyWithImpl<$Res, _$_RoastConfig>
    implements _$$_RoastConfigCopyWith<$Res> {
  __$$_RoastConfigCopyWithImpl(
      _$_RoastConfig _value, $Res Function(_$_RoastConfig) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tempInterval = null,
    Object? preheatTarget = freezed,
    Object? preheatTimeEst = freezed,
    Object? targetDevelopment = null,
  }) {
    return _then(_$_RoastConfig(
      tempInterval: null == tempInterval
          ? _value.tempInterval
          : tempInterval // ignore: cast_nullable_to_non_nullable
              as int,
      preheatTarget: freezed == preheatTarget
          ? _value.preheatTarget
          : preheatTarget // ignore: cast_nullable_to_non_nullable
              as int?,
      preheatTimeEst: freezed == preheatTimeEst
          ? _value.preheatTimeEst
          : preheatTimeEst // ignore: cast_nullable_to_non_nullable
              as Duration?,
      targetDevelopment: null == targetDevelopment
          ? _value.targetDevelopment
          : targetDevelopment // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_RoastConfig implements _RoastConfig {
  const _$_RoastConfig(
      {required this.tempInterval,
      this.preheatTarget,
      this.preheatTimeEst,
      required this.targetDevelopment});

  factory _$_RoastConfig.fromJson(Map<String, dynamic> json) =>
      _$$_RoastConfigFromJson(json);

  @override
  final int tempInterval;
  @override
  final int? preheatTarget;
  @override
  final Duration? preheatTimeEst;
  @override
  final double targetDevelopment;

  @override
  String toString() {
    return 'RoastConfig(tempInterval: $tempInterval, preheatTarget: $preheatTarget, preheatTimeEst: $preheatTimeEst, targetDevelopment: $targetDevelopment)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RoastConfig &&
            (identical(other.tempInterval, tempInterval) ||
                other.tempInterval == tempInterval) &&
            (identical(other.preheatTarget, preheatTarget) ||
                other.preheatTarget == preheatTarget) &&
            (identical(other.preheatTimeEst, preheatTimeEst) ||
                other.preheatTimeEst == preheatTimeEst) &&
            (identical(other.targetDevelopment, targetDevelopment) ||
                other.targetDevelopment == targetDevelopment));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, tempInterval, preheatTarget,
      preheatTimeEst, targetDevelopment);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RoastConfigCopyWith<_$_RoastConfig> get copyWith =>
      __$$_RoastConfigCopyWithImpl<_$_RoastConfig>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_RoastConfigToJson(
      this,
    );
  }
}

abstract class _RoastConfig implements RoastConfig {
  const factory _RoastConfig(
      {required final int tempInterval,
      final int? preheatTarget,
      final Duration? preheatTimeEst,
      required final double targetDevelopment}) = _$_RoastConfig;

  factory _RoastConfig.fromJson(Map<String, dynamic> json) =
      _$_RoastConfig.fromJson;

  @override
  int get tempInterval;
  @override
  int? get preheatTarget;
  @override
  Duration? get preheatTimeEst;
  @override
  double get targetDevelopment;
  @override
  @JsonKey(ignore: true)
  _$$_RoastConfigCopyWith<_$_RoastConfig> get copyWith =>
      throw _privateConstructorUsedError;
}
