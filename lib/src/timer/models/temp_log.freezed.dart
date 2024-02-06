// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'temp_log.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$TempLog {
  Duration get time => throw _privateConstructorUsedError;
  int get temp => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TempLogCopyWith<TempLog> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TempLogCopyWith<$Res> {
  factory $TempLogCopyWith(TempLog value, $Res Function(TempLog) then) =
      _$TempLogCopyWithImpl<$Res, TempLog>;
  @useResult
  $Res call({Duration time, int temp});
}

/// @nodoc
class _$TempLogCopyWithImpl<$Res, $Val extends TempLog>
    implements $TempLogCopyWith<$Res> {
  _$TempLogCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? time = null,
    Object? temp = null,
  }) {
    return _then(_value.copyWith(
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as Duration,
      temp: null == temp
          ? _value.temp
          : temp // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TempLogCopyWith<$Res> implements $TempLogCopyWith<$Res> {
  factory _$$_TempLogCopyWith(
          _$_TempLog value, $Res Function(_$_TempLog) then) =
      __$$_TempLogCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Duration time, int temp});
}

/// @nodoc
class __$$_TempLogCopyWithImpl<$Res>
    extends _$TempLogCopyWithImpl<$Res, _$_TempLog>
    implements _$$_TempLogCopyWith<$Res> {
  __$$_TempLogCopyWithImpl(_$_TempLog _value, $Res Function(_$_TempLog) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? time = null,
    Object? temp = null,
  }) {
    return _then(_$_TempLog(
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as Duration,
      temp: null == temp
          ? _value.temp
          : temp // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_TempLog implements _TempLog {
  const _$_TempLog({required this.time, required this.temp});

  @override
  final Duration time;
  @override
  final int temp;

  @override
  String toString() {
    return 'TempLog(time: $time, temp: $temp)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TempLog &&
            (identical(other.time, time) || other.time == time) &&
            (identical(other.temp, temp) || other.temp == temp));
  }

  @override
  int get hashCode => Object.hash(runtimeType, time, temp);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TempLogCopyWith<_$_TempLog> get copyWith =>
      __$$_TempLogCopyWithImpl<_$_TempLog>(this, _$identity);
}

abstract class _TempLog implements TempLog {
  const factory _TempLog(
      {required final Duration time, required final int temp}) = _$_TempLog;

  @override
  Duration get time;
  @override
  int get temp;
  @override
  @JsonKey(ignore: true)
  _$$_TempLogCopyWith<_$_TempLog> get copyWith =>
      throw _privateConstructorUsedError;
}
