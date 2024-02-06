// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'roast_log.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$RoastLog {
  Duration get time => throw _privateConstructorUsedError;
  int? get temp => throw _privateConstructorUsedError;
  Phase? get phase => throw _privateConstructorUsedError;
  Control? get control => throw _privateConstructorUsedError;
  double? get rateOfRise => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RoastLogCopyWith<RoastLog> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RoastLogCopyWith<$Res> {
  factory $RoastLogCopyWith(RoastLog value, $Res Function(RoastLog) then) =
      _$RoastLogCopyWithImpl<$Res, RoastLog>;
  @useResult
  $Res call(
      {Duration time,
      int? temp,
      Phase? phase,
      Control? control,
      double? rateOfRise});
}

/// @nodoc
class _$RoastLogCopyWithImpl<$Res, $Val extends RoastLog>
    implements $RoastLogCopyWith<$Res> {
  _$RoastLogCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? time = null,
    Object? temp = freezed,
    Object? phase = freezed,
    Object? control = freezed,
    Object? rateOfRise = freezed,
  }) {
    return _then(_value.copyWith(
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as Duration,
      temp: freezed == temp
          ? _value.temp
          : temp // ignore: cast_nullable_to_non_nullable
              as int?,
      phase: freezed == phase
          ? _value.phase
          : phase // ignore: cast_nullable_to_non_nullable
              as Phase?,
      control: freezed == control
          ? _value.control
          : control // ignore: cast_nullable_to_non_nullable
              as Control?,
      rateOfRise: freezed == rateOfRise
          ? _value.rateOfRise
          : rateOfRise // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_RoastLogCopyWith<$Res> implements $RoastLogCopyWith<$Res> {
  factory _$$_RoastLogCopyWith(
          _$_RoastLog value, $Res Function(_$_RoastLog) then) =
      __$$_RoastLogCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Duration time,
      int? temp,
      Phase? phase,
      Control? control,
      double? rateOfRise});
}

/// @nodoc
class __$$_RoastLogCopyWithImpl<$Res>
    extends _$RoastLogCopyWithImpl<$Res, _$_RoastLog>
    implements _$$_RoastLogCopyWith<$Res> {
  __$$_RoastLogCopyWithImpl(
      _$_RoastLog _value, $Res Function(_$_RoastLog) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? time = null,
    Object? temp = freezed,
    Object? phase = freezed,
    Object? control = freezed,
    Object? rateOfRise = freezed,
  }) {
    return _then(_$_RoastLog(
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as Duration,
      temp: freezed == temp
          ? _value.temp
          : temp // ignore: cast_nullable_to_non_nullable
              as int?,
      phase: freezed == phase
          ? _value.phase
          : phase // ignore: cast_nullable_to_non_nullable
              as Phase?,
      control: freezed == control
          ? _value.control
          : control // ignore: cast_nullable_to_non_nullable
              as Control?,
      rateOfRise: freezed == rateOfRise
          ? _value.rateOfRise
          : rateOfRise // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc

class _$_RoastLog implements _RoastLog {
  const _$_RoastLog(
      {required this.time,
      this.temp,
      this.phase,
      this.control,
      this.rateOfRise});

  @override
  final Duration time;
  @override
  final int? temp;
  @override
  final Phase? phase;
  @override
  final Control? control;
  @override
  final double? rateOfRise;

  @override
  String toString() {
    return 'RoastLog(time: $time, temp: $temp, phase: $phase, control: $control, rateOfRise: $rateOfRise)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RoastLog &&
            (identical(other.time, time) || other.time == time) &&
            (identical(other.temp, temp) || other.temp == temp) &&
            (identical(other.phase, phase) || other.phase == phase) &&
            (identical(other.control, control) || other.control == control) &&
            (identical(other.rateOfRise, rateOfRise) ||
                other.rateOfRise == rateOfRise));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, time, temp, phase, control, rateOfRise);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RoastLogCopyWith<_$_RoastLog> get copyWith =>
      __$$_RoastLogCopyWithImpl<_$_RoastLog>(this, _$identity);
}

abstract class _RoastLog implements RoastLog {
  const factory _RoastLog(
      {required final Duration time,
      final int? temp,
      final Phase? phase,
      final Control? control,
      final double? rateOfRise}) = _$_RoastLog;

  @override
  Duration get time;
  @override
  int? get temp;
  @override
  Phase? get phase;
  @override
  Control? get control;
  @override
  double? get rateOfRise;
  @override
  @JsonKey(ignore: true)
  _$$_RoastLogCopyWith<_$_RoastLog> get copyWith =>
      throw _privateConstructorUsedError;
}
