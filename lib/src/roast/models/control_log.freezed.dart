// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'control_log.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ControlLog _$ControlLogFromJson(Map<String, dynamic> json) {
  return _ControlLog.fromJson(json);
}

/// @nodoc
mixin _$ControlLog {
  Duration get time => throw _privateConstructorUsedError;
  Control get control => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ControlLogCopyWith<ControlLog> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ControlLogCopyWith<$Res> {
  factory $ControlLogCopyWith(
          ControlLog value, $Res Function(ControlLog) then) =
      _$ControlLogCopyWithImpl<$Res, ControlLog>;
  @useResult
  $Res call({Duration time, Control control});
}

/// @nodoc
class _$ControlLogCopyWithImpl<$Res, $Val extends ControlLog>
    implements $ControlLogCopyWith<$Res> {
  _$ControlLogCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? time = null,
    Object? control = null,
  }) {
    return _then(_value.copyWith(
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as Duration,
      control: null == control
          ? _value.control
          : control // ignore: cast_nullable_to_non_nullable
              as Control,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ControlLogCopyWith<$Res>
    implements $ControlLogCopyWith<$Res> {
  factory _$$_ControlLogCopyWith(
          _$_ControlLog value, $Res Function(_$_ControlLog) then) =
      __$$_ControlLogCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Duration time, Control control});
}

/// @nodoc
class __$$_ControlLogCopyWithImpl<$Res>
    extends _$ControlLogCopyWithImpl<$Res, _$_ControlLog>
    implements _$$_ControlLogCopyWith<$Res> {
  __$$_ControlLogCopyWithImpl(
      _$_ControlLog _value, $Res Function(_$_ControlLog) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? time = null,
    Object? control = null,
  }) {
    return _then(_$_ControlLog(
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as Duration,
      control: null == control
          ? _value.control
          : control // ignore: cast_nullable_to_non_nullable
              as Control,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ControlLog implements _ControlLog {
  const _$_ControlLog({required this.time, required this.control});

  factory _$_ControlLog.fromJson(Map<String, dynamic> json) =>
      _$$_ControlLogFromJson(json);

  @override
  final Duration time;
  @override
  final Control control;

  @override
  String toString() {
    return 'ControlLog(time: $time, control: $control)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ControlLog &&
            (identical(other.time, time) || other.time == time) &&
            (identical(other.control, control) || other.control == control));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, time, control);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ControlLogCopyWith<_$_ControlLog> get copyWith =>
      __$$_ControlLogCopyWithImpl<_$_ControlLog>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ControlLogToJson(
      this,
    );
  }
}

abstract class _ControlLog implements ControlLog {
  const factory _ControlLog(
      {required final Duration time,
      required final Control control}) = _$_ControlLog;

  factory _ControlLog.fromJson(Map<String, dynamic> json) =
      _$_ControlLog.fromJson;

  @override
  Duration get time;
  @override
  Control get control;
  @override
  @JsonKey(ignore: true)
  _$$_ControlLogCopyWith<_$_ControlLog> get copyWith =>
      throw _privateConstructorUsedError;
}
