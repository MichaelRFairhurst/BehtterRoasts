// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'instruction.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$CoreInstruction {
  int get index => throw _privateConstructorUsedError;
  int? get temp => throw _privateConstructorUsedError;
  Duration get time => throw _privateConstructorUsedError;
  Control get control => throw _privateConstructorUsedError;
  bool get skipped => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CoreInstructionCopyWith<CoreInstruction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CoreInstructionCopyWith<$Res> {
  factory $CoreInstructionCopyWith(
          CoreInstruction value, $Res Function(CoreInstruction) then) =
      _$CoreInstructionCopyWithImpl<$Res, CoreInstruction>;
  @useResult
  $Res call(
      {int index, int? temp, Duration time, Control control, bool skipped});
}

/// @nodoc
class _$CoreInstructionCopyWithImpl<$Res, $Val extends CoreInstruction>
    implements $CoreInstructionCopyWith<$Res> {
  _$CoreInstructionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? index = null,
    Object? temp = freezed,
    Object? time = null,
    Object? control = null,
    Object? skipped = null,
  }) {
    return _then(_value.copyWith(
      index: null == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
      temp: freezed == temp
          ? _value.temp
          : temp // ignore: cast_nullable_to_non_nullable
              as int?,
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as Duration,
      control: null == control
          ? _value.control
          : control // ignore: cast_nullable_to_non_nullable
              as Control,
      skipped: null == skipped
          ? _value.skipped
          : skipped // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CoreInstructionCopyWith<$Res>
    implements $CoreInstructionCopyWith<$Res> {
  factory _$$_CoreInstructionCopyWith(
          _$_CoreInstruction value, $Res Function(_$_CoreInstruction) then) =
      __$$_CoreInstructionCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int index, int? temp, Duration time, Control control, bool skipped});
}

/// @nodoc
class __$$_CoreInstructionCopyWithImpl<$Res>
    extends _$CoreInstructionCopyWithImpl<$Res, _$_CoreInstruction>
    implements _$$_CoreInstructionCopyWith<$Res> {
  __$$_CoreInstructionCopyWithImpl(
      _$_CoreInstruction _value, $Res Function(_$_CoreInstruction) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? index = null,
    Object? temp = freezed,
    Object? time = null,
    Object? control = null,
    Object? skipped = null,
  }) {
    return _then(_$_CoreInstruction(
      index: null == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
      temp: freezed == temp
          ? _value.temp
          : temp // ignore: cast_nullable_to_non_nullable
              as int?,
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as Duration,
      control: null == control
          ? _value.control
          : control // ignore: cast_nullable_to_non_nullable
              as Control,
      skipped: null == skipped
          ? _value.skipped
          : skipped // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_CoreInstruction implements _CoreInstruction {
  const _$_CoreInstruction(
      {required this.index,
      required this.temp,
      required this.time,
      required this.control,
      this.skipped = false});

  @override
  final int index;
  @override
  final int? temp;
  @override
  final Duration time;
  @override
  final Control control;
  @override
  @JsonKey()
  final bool skipped;

  @override
  String toString() {
    return 'CoreInstruction(index: $index, temp: $temp, time: $time, control: $control, skipped: $skipped)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CoreInstruction &&
            (identical(other.index, index) || other.index == index) &&
            (identical(other.temp, temp) || other.temp == temp) &&
            (identical(other.time, time) || other.time == time) &&
            (identical(other.control, control) || other.control == control) &&
            (identical(other.skipped, skipped) || other.skipped == skipped));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, index, temp, time, control, skipped);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CoreInstructionCopyWith<_$_CoreInstruction> get copyWith =>
      __$$_CoreInstructionCopyWithImpl<_$_CoreInstruction>(this, _$identity);
}

abstract class _CoreInstruction implements CoreInstruction {
  const factory _CoreInstruction(
      {required final int index,
      required final int? temp,
      required final Duration time,
      required final Control control,
      final bool skipped}) = _$_CoreInstruction;

  @override
  int get index;
  @override
  int? get temp;
  @override
  Duration get time;
  @override
  Control get control;
  @override
  bool get skipped;
  @override
  @JsonKey(ignore: true)
  _$$_CoreInstructionCopyWith<_$_CoreInstruction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$TemporalInstruction {
  Duration get time => throw _privateConstructorUsedError;
  CoreInstruction get core => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TemporalInstructionCopyWith<TemporalInstruction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TemporalInstructionCopyWith<$Res> {
  factory $TemporalInstructionCopyWith(
          TemporalInstruction value, $Res Function(TemporalInstruction) then) =
      _$TemporalInstructionCopyWithImpl<$Res, TemporalInstruction>;
  @useResult
  $Res call({Duration time, CoreInstruction core});

  $CoreInstructionCopyWith<$Res> get core;
}

/// @nodoc
class _$TemporalInstructionCopyWithImpl<$Res, $Val extends TemporalInstruction>
    implements $TemporalInstructionCopyWith<$Res> {
  _$TemporalInstructionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? time = null,
    Object? core = null,
  }) {
    return _then(_value.copyWith(
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as Duration,
      core: null == core
          ? _value.core
          : core // ignore: cast_nullable_to_non_nullable
              as CoreInstruction,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $CoreInstructionCopyWith<$Res> get core {
    return $CoreInstructionCopyWith<$Res>(_value.core, (value) {
      return _then(_value.copyWith(core: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_TemporalInstructionCopyWith<$Res>
    implements $TemporalInstructionCopyWith<$Res> {
  factory _$$_TemporalInstructionCopyWith(_$_TemporalInstruction value,
          $Res Function(_$_TemporalInstruction) then) =
      __$$_TemporalInstructionCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Duration time, CoreInstruction core});

  @override
  $CoreInstructionCopyWith<$Res> get core;
}

/// @nodoc
class __$$_TemporalInstructionCopyWithImpl<$Res>
    extends _$TemporalInstructionCopyWithImpl<$Res, _$_TemporalInstruction>
    implements _$$_TemporalInstructionCopyWith<$Res> {
  __$$_TemporalInstructionCopyWithImpl(_$_TemporalInstruction _value,
      $Res Function(_$_TemporalInstruction) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? time = null,
    Object? core = null,
  }) {
    return _then(_$_TemporalInstruction(
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as Duration,
      core: null == core
          ? _value.core
          : core // ignore: cast_nullable_to_non_nullable
              as CoreInstruction,
    ));
  }
}

/// @nodoc

class _$_TemporalInstruction implements _TemporalInstruction {
  const _$_TemporalInstruction({required this.time, required this.core});

  @override
  final Duration time;
  @override
  final CoreInstruction core;

  @override
  String toString() {
    return 'TemporalInstruction(time: $time, core: $core)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TemporalInstruction &&
            (identical(other.time, time) || other.time == time) &&
            (identical(other.core, core) || other.core == core));
  }

  @override
  int get hashCode => Object.hash(runtimeType, time, core);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TemporalInstructionCopyWith<_$_TemporalInstruction> get copyWith =>
      __$$_TemporalInstructionCopyWithImpl<_$_TemporalInstruction>(
          this, _$identity);
}

abstract class _TemporalInstruction implements TemporalInstruction {
  const factory _TemporalInstruction(
      {required final Duration time,
      required final CoreInstruction core}) = _$_TemporalInstruction;

  @override
  Duration get time;
  @override
  CoreInstruction get core;
  @override
  @JsonKey(ignore: true)
  _$$_TemporalInstructionCopyWith<_$_TemporalInstruction> get copyWith =>
      throw _privateConstructorUsedError;
}
