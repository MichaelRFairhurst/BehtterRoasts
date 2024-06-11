// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'preheat.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Preheat _$PreheatFromJson(Map<String, dynamic> json) {
  return _Preheat.fromJson(json);
}

/// @nodoc
mixin _$Preheat {
  DateTime get start => throw _privateConstructorUsedError;
  Duration get end => throw _privateConstructorUsedError;
  int get temp => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PreheatCopyWith<Preheat> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PreheatCopyWith<$Res> {
  factory $PreheatCopyWith(Preheat value, $Res Function(Preheat) then) =
      _$PreheatCopyWithImpl<$Res, Preheat>;
  @useResult
  $Res call({DateTime start, Duration end, int temp});
}

/// @nodoc
class _$PreheatCopyWithImpl<$Res, $Val extends Preheat>
    implements $PreheatCopyWith<$Res> {
  _$PreheatCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? start = null,
    Object? end = null,
    Object? temp = null,
  }) {
    return _then(_value.copyWith(
      start: null == start
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as DateTime,
      end: null == end
          ? _value.end
          : end // ignore: cast_nullable_to_non_nullable
              as Duration,
      temp: null == temp
          ? _value.temp
          : temp // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PreheatCopyWith<$Res> implements $PreheatCopyWith<$Res> {
  factory _$$_PreheatCopyWith(
          _$_Preheat value, $Res Function(_$_Preheat) then) =
      __$$_PreheatCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({DateTime start, Duration end, int temp});
}

/// @nodoc
class __$$_PreheatCopyWithImpl<$Res>
    extends _$PreheatCopyWithImpl<$Res, _$_Preheat>
    implements _$$_PreheatCopyWith<$Res> {
  __$$_PreheatCopyWithImpl(_$_Preheat _value, $Res Function(_$_Preheat) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? start = null,
    Object? end = null,
    Object? temp = null,
  }) {
    return _then(_$_Preheat(
      start: null == start
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as DateTime,
      end: null == end
          ? _value.end
          : end // ignore: cast_nullable_to_non_nullable
              as Duration,
      temp: null == temp
          ? _value.temp
          : temp // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Preheat implements _Preheat {
  const _$_Preheat(
      {required this.start, required this.end, required this.temp});

  factory _$_Preheat.fromJson(Map<String, dynamic> json) =>
      _$$_PreheatFromJson(json);

  @override
  final DateTime start;
  @override
  final Duration end;
  @override
  final int temp;

  @override
  String toString() {
    return 'Preheat(start: $start, end: $end, temp: $temp)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Preheat &&
            (identical(other.start, start) || other.start == start) &&
            (identical(other.end, end) || other.end == end) &&
            (identical(other.temp, temp) || other.temp == temp));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, start, end, temp);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PreheatCopyWith<_$_Preheat> get copyWith =>
      __$$_PreheatCopyWithImpl<_$_Preheat>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PreheatToJson(
      this,
    );
  }
}

abstract class _Preheat implements Preheat {
  const factory _Preheat(
      {required final DateTime start,
      required final Duration end,
      required final int temp}) = _$_Preheat;

  factory _Preheat.fromJson(Map<String, dynamic> json) = _$_Preheat.fromJson;

  @override
  DateTime get start;
  @override
  Duration get end;
  @override
  int get temp;
  @override
  @JsonKey(ignore: true)
  _$$_PreheatCopyWith<_$_Preheat> get copyWith =>
      throw _privateConstructorUsedError;
}
