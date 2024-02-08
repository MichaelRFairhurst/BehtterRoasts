// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'projection.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$Projection {
  Duration? get roastTime => throw _privateConstructorUsedError;
  Duration? get timeRemaining => throw _privateConstructorUsedError;
  double? get currentTemp => throw _privateConstructorUsedError;
  double? get temp30s => throw _privateConstructorUsedError;
  double? get temp60s => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ProjectionCopyWith<Projection> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProjectionCopyWith<$Res> {
  factory $ProjectionCopyWith(
          Projection value, $Res Function(Projection) then) =
      _$ProjectionCopyWithImpl<$Res, Projection>;
  @useResult
  $Res call(
      {Duration? roastTime,
      Duration? timeRemaining,
      double? currentTemp,
      double? temp30s,
      double? temp60s});
}

/// @nodoc
class _$ProjectionCopyWithImpl<$Res, $Val extends Projection>
    implements $ProjectionCopyWith<$Res> {
  _$ProjectionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? roastTime = freezed,
    Object? timeRemaining = freezed,
    Object? currentTemp = freezed,
    Object? temp30s = freezed,
    Object? temp60s = freezed,
  }) {
    return _then(_value.copyWith(
      roastTime: freezed == roastTime
          ? _value.roastTime
          : roastTime // ignore: cast_nullable_to_non_nullable
              as Duration?,
      timeRemaining: freezed == timeRemaining
          ? _value.timeRemaining
          : timeRemaining // ignore: cast_nullable_to_non_nullable
              as Duration?,
      currentTemp: freezed == currentTemp
          ? _value.currentTemp
          : currentTemp // ignore: cast_nullable_to_non_nullable
              as double?,
      temp30s: freezed == temp30s
          ? _value.temp30s
          : temp30s // ignore: cast_nullable_to_non_nullable
              as double?,
      temp60s: freezed == temp60s
          ? _value.temp60s
          : temp60s // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ProjectionCopyWith<$Res>
    implements $ProjectionCopyWith<$Res> {
  factory _$$_ProjectionCopyWith(
          _$_Projection value, $Res Function(_$_Projection) then) =
      __$$_ProjectionCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Duration? roastTime,
      Duration? timeRemaining,
      double? currentTemp,
      double? temp30s,
      double? temp60s});
}

/// @nodoc
class __$$_ProjectionCopyWithImpl<$Res>
    extends _$ProjectionCopyWithImpl<$Res, _$_Projection>
    implements _$$_ProjectionCopyWith<$Res> {
  __$$_ProjectionCopyWithImpl(
      _$_Projection _value, $Res Function(_$_Projection) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? roastTime = freezed,
    Object? timeRemaining = freezed,
    Object? currentTemp = freezed,
    Object? temp30s = freezed,
    Object? temp60s = freezed,
  }) {
    return _then(_$_Projection(
      roastTime: freezed == roastTime
          ? _value.roastTime
          : roastTime // ignore: cast_nullable_to_non_nullable
              as Duration?,
      timeRemaining: freezed == timeRemaining
          ? _value.timeRemaining
          : timeRemaining // ignore: cast_nullable_to_non_nullable
              as Duration?,
      currentTemp: freezed == currentTemp
          ? _value.currentTemp
          : currentTemp // ignore: cast_nullable_to_non_nullable
              as double?,
      temp30s: freezed == temp30s
          ? _value.temp30s
          : temp30s // ignore: cast_nullable_to_non_nullable
              as double?,
      temp60s: freezed == temp60s
          ? _value.temp60s
          : temp60s // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc

class _$_Projection implements _Projection {
  const _$_Projection(
      {required this.roastTime,
      required this.timeRemaining,
      required this.currentTemp,
      required this.temp30s,
      required this.temp60s});

  @override
  final Duration? roastTime;
  @override
  final Duration? timeRemaining;
  @override
  final double? currentTemp;
  @override
  final double? temp30s;
  @override
  final double? temp60s;

  @override
  String toString() {
    return 'Projection(roastTime: $roastTime, timeRemaining: $timeRemaining, currentTemp: $currentTemp, temp30s: $temp30s, temp60s: $temp60s)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Projection &&
            (identical(other.roastTime, roastTime) ||
                other.roastTime == roastTime) &&
            (identical(other.timeRemaining, timeRemaining) ||
                other.timeRemaining == timeRemaining) &&
            (identical(other.currentTemp, currentTemp) ||
                other.currentTemp == currentTemp) &&
            (identical(other.temp30s, temp30s) || other.temp30s == temp30s) &&
            (identical(other.temp60s, temp60s) || other.temp60s == temp60s));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, roastTime, timeRemaining, currentTemp, temp30s, temp60s);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ProjectionCopyWith<_$_Projection> get copyWith =>
      __$$_ProjectionCopyWithImpl<_$_Projection>(this, _$identity);
}

abstract class _Projection implements Projection {
  const factory _Projection(
      {required final Duration? roastTime,
      required final Duration? timeRemaining,
      required final double? currentTemp,
      required final double? temp30s,
      required final double? temp60s}) = _$_Projection;

  @override
  Duration? get roastTime;
  @override
  Duration? get timeRemaining;
  @override
  double? get currentTemp;
  @override
  double? get temp30s;
  @override
  double? get temp60s;
  @override
  @JsonKey(ignore: true)
  _$$_ProjectionCopyWith<_$_Projection> get copyWith =>
      throw _privateConstructorUsedError;
}
