// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'roast.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Roast _$RoastFromJson(Map<String, dynamic> json) {
  return _Roast.fromJson(json);
}

/// @nodoc
mixin _$Roast {
  Bean get bean => throw _privateConstructorUsedError;
  RoastConfig get config => throw _privateConstructorUsedError;
  int get roastNumber => throw _privateConstructorUsedError;
  double get weightIn => throw _privateConstructorUsedError;
  double get weightOut => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RoastCopyWith<Roast> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RoastCopyWith<$Res> {
  factory $RoastCopyWith(Roast value, $Res Function(Roast) then) =
      _$RoastCopyWithImpl<$Res, Roast>;
  @useResult
  $Res call(
      {Bean bean,
      RoastConfig config,
      int roastNumber,
      double weightIn,
      double weightOut});

  $BeanCopyWith<$Res> get bean;
  $RoastConfigCopyWith<$Res> get config;
}

/// @nodoc
class _$RoastCopyWithImpl<$Res, $Val extends Roast>
    implements $RoastCopyWith<$Res> {
  _$RoastCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bean = null,
    Object? config = null,
    Object? roastNumber = null,
    Object? weightIn = null,
    Object? weightOut = null,
  }) {
    return _then(_value.copyWith(
      bean: null == bean
          ? _value.bean
          : bean // ignore: cast_nullable_to_non_nullable
              as Bean,
      config: null == config
          ? _value.config
          : config // ignore: cast_nullable_to_non_nullable
              as RoastConfig,
      roastNumber: null == roastNumber
          ? _value.roastNumber
          : roastNumber // ignore: cast_nullable_to_non_nullable
              as int,
      weightIn: null == weightIn
          ? _value.weightIn
          : weightIn // ignore: cast_nullable_to_non_nullable
              as double,
      weightOut: null == weightOut
          ? _value.weightOut
          : weightOut // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $BeanCopyWith<$Res> get bean {
    return $BeanCopyWith<$Res>(_value.bean, (value) {
      return _then(_value.copyWith(bean: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $RoastConfigCopyWith<$Res> get config {
    return $RoastConfigCopyWith<$Res>(_value.config, (value) {
      return _then(_value.copyWith(config: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_RoastCopyWith<$Res> implements $RoastCopyWith<$Res> {
  factory _$$_RoastCopyWith(_$_Roast value, $Res Function(_$_Roast) then) =
      __$$_RoastCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Bean bean,
      RoastConfig config,
      int roastNumber,
      double weightIn,
      double weightOut});

  @override
  $BeanCopyWith<$Res> get bean;
  @override
  $RoastConfigCopyWith<$Res> get config;
}

/// @nodoc
class __$$_RoastCopyWithImpl<$Res> extends _$RoastCopyWithImpl<$Res, _$_Roast>
    implements _$$_RoastCopyWith<$Res> {
  __$$_RoastCopyWithImpl(_$_Roast _value, $Res Function(_$_Roast) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bean = null,
    Object? config = null,
    Object? roastNumber = null,
    Object? weightIn = null,
    Object? weightOut = null,
  }) {
    return _then(_$_Roast(
      bean: null == bean
          ? _value.bean
          : bean // ignore: cast_nullable_to_non_nullable
              as Bean,
      config: null == config
          ? _value.config
          : config // ignore: cast_nullable_to_non_nullable
              as RoastConfig,
      roastNumber: null == roastNumber
          ? _value.roastNumber
          : roastNumber // ignore: cast_nullable_to_non_nullable
              as int,
      weightIn: null == weightIn
          ? _value.weightIn
          : weightIn // ignore: cast_nullable_to_non_nullable
              as double,
      weightOut: null == weightOut
          ? _value.weightOut
          : weightOut // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Roast implements _Roast {
  const _$_Roast(
      {required this.bean,
      required this.config,
      required this.roastNumber,
      required this.weightIn,
      required this.weightOut});

  factory _$_Roast.fromJson(Map<String, dynamic> json) =>
      _$$_RoastFromJson(json);

  @override
  final Bean bean;
  @override
  final RoastConfig config;
  @override
  final int roastNumber;
  @override
  final double weightIn;
  @override
  final double weightOut;

  @override
  String toString() {
    return 'Roast(bean: $bean, config: $config, roastNumber: $roastNumber, weightIn: $weightIn, weightOut: $weightOut)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Roast &&
            (identical(other.bean, bean) || other.bean == bean) &&
            (identical(other.config, config) || other.config == config) &&
            (identical(other.roastNumber, roastNumber) ||
                other.roastNumber == roastNumber) &&
            (identical(other.weightIn, weightIn) ||
                other.weightIn == weightIn) &&
            (identical(other.weightOut, weightOut) ||
                other.weightOut == weightOut));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, bean, config, roastNumber, weightIn, weightOut);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RoastCopyWith<_$_Roast> get copyWith =>
      __$$_RoastCopyWithImpl<_$_Roast>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_RoastToJson(
      this,
    );
  }
}

abstract class _Roast implements Roast {
  const factory _Roast(
      {required final Bean bean,
      required final RoastConfig config,
      required final int roastNumber,
      required final double weightIn,
      required final double weightOut}) = _$_Roast;

  factory _Roast.fromJson(Map<String, dynamic> json) = _$_Roast.fromJson;

  @override
  Bean get bean;
  @override
  RoastConfig get config;
  @override
  int get roastNumber;
  @override
  double get weightIn;
  @override
  double get weightOut;
  @override
  @JsonKey(ignore: true)
  _$$_RoastCopyWith<_$_Roast> get copyWith =>
      throw _privateConstructorUsedError;
}
