// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'toggle_switch_style.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ToggleSwitchStyle {
  Color get backgroundColor => throw _privateConstructorUsedError;
  Color get pillColor => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ToggleSwitchStyleCopyWith<ToggleSwitchStyle> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ToggleSwitchStyleCopyWith<$Res> {
  factory $ToggleSwitchStyleCopyWith(
          ToggleSwitchStyle value, $Res Function(ToggleSwitchStyle) then) =
      _$ToggleSwitchStyleCopyWithImpl<$Res, ToggleSwitchStyle>;
  @useResult
  $Res call({Color backgroundColor, Color pillColor});
}

/// @nodoc
class _$ToggleSwitchStyleCopyWithImpl<$Res, $Val extends ToggleSwitchStyle>
    implements $ToggleSwitchStyleCopyWith<$Res> {
  _$ToggleSwitchStyleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? backgroundColor = null,
    Object? pillColor = null,
  }) {
    return _then(_value.copyWith(
      backgroundColor: null == backgroundColor
          ? _value.backgroundColor
          : backgroundColor // ignore: cast_nullable_to_non_nullable
              as Color,
      pillColor: null == pillColor
          ? _value.pillColor
          : pillColor // ignore: cast_nullable_to_non_nullable
              as Color,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ToggleSwitchStyleCopyWith<$Res>
    implements $ToggleSwitchStyleCopyWith<$Res> {
  factory _$$_ToggleSwitchStyleCopyWith(_$_ToggleSwitchStyle value,
          $Res Function(_$_ToggleSwitchStyle) then) =
      __$$_ToggleSwitchStyleCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Color backgroundColor, Color pillColor});
}

/// @nodoc
class __$$_ToggleSwitchStyleCopyWithImpl<$Res>
    extends _$ToggleSwitchStyleCopyWithImpl<$Res, _$_ToggleSwitchStyle>
    implements _$$_ToggleSwitchStyleCopyWith<$Res> {
  __$$_ToggleSwitchStyleCopyWithImpl(
      _$_ToggleSwitchStyle _value, $Res Function(_$_ToggleSwitchStyle) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? backgroundColor = null,
    Object? pillColor = null,
  }) {
    return _then(_$_ToggleSwitchStyle(
      backgroundColor: null == backgroundColor
          ? _value.backgroundColor
          : backgroundColor // ignore: cast_nullable_to_non_nullable
              as Color,
      pillColor: null == pillColor
          ? _value.pillColor
          : pillColor // ignore: cast_nullable_to_non_nullable
              as Color,
    ));
  }
}

/// @nodoc

class _$_ToggleSwitchStyle implements _ToggleSwitchStyle {
  const _$_ToggleSwitchStyle(
      {required this.backgroundColor, required this.pillColor});

  @override
  final Color backgroundColor;
  @override
  final Color pillColor;

  @override
  String toString() {
    return 'ToggleSwitchStyle(backgroundColor: $backgroundColor, pillColor: $pillColor)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ToggleSwitchStyle &&
            (identical(other.backgroundColor, backgroundColor) ||
                other.backgroundColor == backgroundColor) &&
            (identical(other.pillColor, pillColor) ||
                other.pillColor == pillColor));
  }

  @override
  int get hashCode => Object.hash(runtimeType, backgroundColor, pillColor);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ToggleSwitchStyleCopyWith<_$_ToggleSwitchStyle> get copyWith =>
      __$$_ToggleSwitchStyleCopyWithImpl<_$_ToggleSwitchStyle>(
          this, _$identity);
}

abstract class _ToggleSwitchStyle implements ToggleSwitchStyle {
  const factory _ToggleSwitchStyle(
      {required final Color backgroundColor,
      required final Color pillColor}) = _$_ToggleSwitchStyle;

  @override
  Color get backgroundColor;
  @override
  Color get pillColor;
  @override
  @JsonKey(ignore: true)
  _$$_ToggleSwitchStyleCopyWith<_$_ToggleSwitchStyle> get copyWith =>
      throw _privateConstructorUsedError;
}
