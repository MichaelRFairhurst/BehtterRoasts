// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'alert.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$Alert {
  Severity get severity => throw _privateConstructorUsedError;
  AlertKind get kind => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AlertCopyWith<Alert> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AlertCopyWith<$Res> {
  factory $AlertCopyWith(Alert value, $Res Function(Alert) then) =
      _$AlertCopyWithImpl<$Res, Alert>;
  @useResult
  $Res call({Severity severity, AlertKind kind, String message});
}

/// @nodoc
class _$AlertCopyWithImpl<$Res, $Val extends Alert>
    implements $AlertCopyWith<$Res> {
  _$AlertCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? severity = null,
    Object? kind = null,
    Object? message = null,
  }) {
    return _then(_value.copyWith(
      severity: null == severity
          ? _value.severity
          : severity // ignore: cast_nullable_to_non_nullable
              as Severity,
      kind: null == kind
          ? _value.kind
          : kind // ignore: cast_nullable_to_non_nullable
              as AlertKind,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AlertCopyWith<$Res> implements $AlertCopyWith<$Res> {
  factory _$$_AlertCopyWith(_$_Alert value, $Res Function(_$_Alert) then) =
      __$$_AlertCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Severity severity, AlertKind kind, String message});
}

/// @nodoc
class __$$_AlertCopyWithImpl<$Res> extends _$AlertCopyWithImpl<$Res, _$_Alert>
    implements _$$_AlertCopyWith<$Res> {
  __$$_AlertCopyWithImpl(_$_Alert _value, $Res Function(_$_Alert) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? severity = null,
    Object? kind = null,
    Object? message = null,
  }) {
    return _then(_$_Alert(
      severity: null == severity
          ? _value.severity
          : severity // ignore: cast_nullable_to_non_nullable
              as Severity,
      kind: null == kind
          ? _value.kind
          : kind // ignore: cast_nullable_to_non_nullable
              as AlertKind,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_Alert implements _Alert {
  const _$_Alert(
      {required this.severity, required this.kind, required this.message});

  @override
  final Severity severity;
  @override
  final AlertKind kind;
  @override
  final String message;

  @override
  String toString() {
    return 'Alert(severity: $severity, kind: $kind, message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Alert &&
            (identical(other.severity, severity) ||
                other.severity == severity) &&
            (identical(other.kind, kind) || other.kind == kind) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, severity, kind, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AlertCopyWith<_$_Alert> get copyWith =>
      __$$_AlertCopyWithImpl<_$_Alert>(this, _$identity);
}

abstract class _Alert implements Alert {
  const factory _Alert(
      {required final Severity severity,
      required final AlertKind kind,
      required final String message}) = _$_Alert;

  @override
  Severity get severity;
  @override
  AlertKind get kind;
  @override
  String get message;
  @override
  @JsonKey(ignore: true)
  _$$_AlertCopyWith<_$_Alert> get copyWith =>
      throw _privateConstructorUsedError;
}
