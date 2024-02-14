// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'phase_log.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PhaseLog _$PhaseLogFromJson(Map<String, dynamic> json) {
  return _PhaseLog.fromJson(json);
}

/// @nodoc
mixin _$PhaseLog {
  Duration get time => throw _privateConstructorUsedError;
  Phase get phase => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PhaseLogCopyWith<PhaseLog> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PhaseLogCopyWith<$Res> {
  factory $PhaseLogCopyWith(PhaseLog value, $Res Function(PhaseLog) then) =
      _$PhaseLogCopyWithImpl<$Res, PhaseLog>;
  @useResult
  $Res call({Duration time, Phase phase});
}

/// @nodoc
class _$PhaseLogCopyWithImpl<$Res, $Val extends PhaseLog>
    implements $PhaseLogCopyWith<$Res> {
  _$PhaseLogCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? time = null,
    Object? phase = null,
  }) {
    return _then(_value.copyWith(
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as Duration,
      phase: null == phase
          ? _value.phase
          : phase // ignore: cast_nullable_to_non_nullable
              as Phase,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PhaseLogCopyWith<$Res> implements $PhaseLogCopyWith<$Res> {
  factory _$$_PhaseLogCopyWith(
          _$_PhaseLog value, $Res Function(_$_PhaseLog) then) =
      __$$_PhaseLogCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Duration time, Phase phase});
}

/// @nodoc
class __$$_PhaseLogCopyWithImpl<$Res>
    extends _$PhaseLogCopyWithImpl<$Res, _$_PhaseLog>
    implements _$$_PhaseLogCopyWith<$Res> {
  __$$_PhaseLogCopyWithImpl(
      _$_PhaseLog _value, $Res Function(_$_PhaseLog) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? time = null,
    Object? phase = null,
  }) {
    return _then(_$_PhaseLog(
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as Duration,
      phase: null == phase
          ? _value.phase
          : phase // ignore: cast_nullable_to_non_nullable
              as Phase,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PhaseLog implements _PhaseLog {
  const _$_PhaseLog({required this.time, required this.phase});

  factory _$_PhaseLog.fromJson(Map<String, dynamic> json) =>
      _$$_PhaseLogFromJson(json);

  @override
  final Duration time;
  @override
  final Phase phase;

  @override
  String toString() {
    return 'PhaseLog(time: $time, phase: $phase)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PhaseLog &&
            (identical(other.time, time) || other.time == time) &&
            (identical(other.phase, phase) || other.phase == phase));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, time, phase);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PhaseLogCopyWith<_$_PhaseLog> get copyWith =>
      __$$_PhaseLogCopyWithImpl<_$_PhaseLog>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PhaseLogToJson(
      this,
    );
  }
}

abstract class _PhaseLog implements PhaseLog {
  const factory _PhaseLog(
      {required final Duration time, required final Phase phase}) = _$_PhaseLog;

  factory _PhaseLog.fromJson(Map<String, dynamic> json) = _$_PhaseLog.fromJson;

  @override
  Duration get time;
  @override
  Phase get phase;
  @override
  @JsonKey(ignore: true)
  _$$_PhaseLogCopyWith<_$_PhaseLog> get copyWith =>
      throw _privateConstructorUsedError;
}
