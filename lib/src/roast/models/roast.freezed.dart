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
  String get beanId => throw _privateConstructorUsedError;
  RoastConfig get config => throw _privateConstructorUsedError;
  int get roastNumber => throw _privateConstructorUsedError;
  double get weightIn => throw _privateConstructorUsedError;
  double get weightOut => throw _privateConstructorUsedError;
  DateTime get roasted => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  List<TempLog> get tempLogs => throw _privateConstructorUsedError;
  List<ControlLog> get controlLogs => throw _privateConstructorUsedError;
  List<_PhaseLog> get phaseLogs => throw _privateConstructorUsedError;

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
      {String beanId,
      RoastConfig config,
      int roastNumber,
      double weightIn,
      double weightOut,
      DateTime roasted,
      String? notes,
      List<TempLog> tempLogs,
      List<ControlLog> controlLogs,
      List<_PhaseLog> phaseLogs});

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
    Object? beanId = null,
    Object? config = null,
    Object? roastNumber = null,
    Object? weightIn = null,
    Object? weightOut = null,
    Object? roasted = null,
    Object? notes = freezed,
    Object? tempLogs = null,
    Object? controlLogs = null,
    Object? phaseLogs = null,
  }) {
    return _then(_value.copyWith(
      beanId: null == beanId
          ? _value.beanId
          : beanId // ignore: cast_nullable_to_non_nullable
              as String,
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
      roasted: null == roasted
          ? _value.roasted
          : roasted // ignore: cast_nullable_to_non_nullable
              as DateTime,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      tempLogs: null == tempLogs
          ? _value.tempLogs
          : tempLogs // ignore: cast_nullable_to_non_nullable
              as List<TempLog>,
      controlLogs: null == controlLogs
          ? _value.controlLogs
          : controlLogs // ignore: cast_nullable_to_non_nullable
              as List<ControlLog>,
      phaseLogs: null == phaseLogs
          ? _value.phaseLogs
          : phaseLogs // ignore: cast_nullable_to_non_nullable
              as List<_PhaseLog>,
    ) as $Val);
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
      {String beanId,
      RoastConfig config,
      int roastNumber,
      double weightIn,
      double weightOut,
      DateTime roasted,
      String? notes,
      List<TempLog> tempLogs,
      List<ControlLog> controlLogs,
      List<_PhaseLog> phaseLogs});

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
    Object? beanId = null,
    Object? config = null,
    Object? roastNumber = null,
    Object? weightIn = null,
    Object? weightOut = null,
    Object? roasted = null,
    Object? notes = freezed,
    Object? tempLogs = null,
    Object? controlLogs = null,
    Object? phaseLogs = null,
  }) {
    return _then(_$_Roast(
      beanId: null == beanId
          ? _value.beanId
          : beanId // ignore: cast_nullable_to_non_nullable
              as String,
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
      roasted: null == roasted
          ? _value.roasted
          : roasted // ignore: cast_nullable_to_non_nullable
              as DateTime,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      tempLogs: null == tempLogs
          ? _value._tempLogs
          : tempLogs // ignore: cast_nullable_to_non_nullable
              as List<TempLog>,
      controlLogs: null == controlLogs
          ? _value._controlLogs
          : controlLogs // ignore: cast_nullable_to_non_nullable
              as List<ControlLog>,
      phaseLogs: null == phaseLogs
          ? _value._phaseLogs
          : phaseLogs // ignore: cast_nullable_to_non_nullable
              as List<_PhaseLog>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Roast extends _Roast {
  const _$_Roast(
      {required this.beanId,
      required this.config,
      required this.roastNumber,
      required this.weightIn,
      required this.weightOut,
      required this.roasted,
      this.notes,
      final List<TempLog> tempLogs = const [],
      final List<ControlLog> controlLogs = const [],
      final List<_PhaseLog> phaseLogs = const []})
      : _tempLogs = tempLogs,
        _controlLogs = controlLogs,
        _phaseLogs = phaseLogs,
        super._();

  factory _$_Roast.fromJson(Map<String, dynamic> json) =>
      _$$_RoastFromJson(json);

  @override
  final String beanId;
  @override
  final RoastConfig config;
  @override
  final int roastNumber;
  @override
  final double weightIn;
  @override
  final double weightOut;
  @override
  final DateTime roasted;
  @override
  final String? notes;
  final List<TempLog> _tempLogs;
  @override
  @JsonKey()
  List<TempLog> get tempLogs {
    if (_tempLogs is EqualUnmodifiableListView) return _tempLogs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tempLogs);
  }

  final List<ControlLog> _controlLogs;
  @override
  @JsonKey()
  List<ControlLog> get controlLogs {
    if (_controlLogs is EqualUnmodifiableListView) return _controlLogs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_controlLogs);
  }

  final List<_PhaseLog> _phaseLogs;
  @override
  @JsonKey()
  List<_PhaseLog> get phaseLogs {
    if (_phaseLogs is EqualUnmodifiableListView) return _phaseLogs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_phaseLogs);
  }

  @override
  String toString() {
    return 'Roast(beanId: $beanId, config: $config, roastNumber: $roastNumber, weightIn: $weightIn, weightOut: $weightOut, roasted: $roasted, notes: $notes, tempLogs: $tempLogs, controlLogs: $controlLogs, phaseLogs: $phaseLogs)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Roast &&
            (identical(other.beanId, beanId) || other.beanId == beanId) &&
            (identical(other.config, config) || other.config == config) &&
            (identical(other.roastNumber, roastNumber) ||
                other.roastNumber == roastNumber) &&
            (identical(other.weightIn, weightIn) ||
                other.weightIn == weightIn) &&
            (identical(other.weightOut, weightOut) ||
                other.weightOut == weightOut) &&
            (identical(other.roasted, roasted) || other.roasted == roasted) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            const DeepCollectionEquality().equals(other._tempLogs, _tempLogs) &&
            const DeepCollectionEquality()
                .equals(other._controlLogs, _controlLogs) &&
            const DeepCollectionEquality()
                .equals(other._phaseLogs, _phaseLogs));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      beanId,
      config,
      roastNumber,
      weightIn,
      weightOut,
      roasted,
      notes,
      const DeepCollectionEquality().hash(_tempLogs),
      const DeepCollectionEquality().hash(_controlLogs),
      const DeepCollectionEquality().hash(_phaseLogs));

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

abstract class _Roast extends Roast {
  const factory _Roast(
      {required final String beanId,
      required final RoastConfig config,
      required final int roastNumber,
      required final double weightIn,
      required final double weightOut,
      required final DateTime roasted,
      final String? notes,
      final List<TempLog> tempLogs,
      final List<ControlLog> controlLogs,
      final List<_PhaseLog> phaseLogs}) = _$_Roast;
  const _Roast._() : super._();

  factory _Roast.fromJson(Map<String, dynamic> json) = _$_Roast.fromJson;

  @override
  String get beanId;
  @override
  RoastConfig get config;
  @override
  int get roastNumber;
  @override
  double get weightIn;
  @override
  double get weightOut;
  @override
  DateTime get roasted;
  @override
  String? get notes;
  @override
  List<TempLog> get tempLogs;
  @override
  List<ControlLog> get controlLogs;
  @override
  List<_PhaseLog> get phaseLogs;
  @override
  @JsonKey(ignore: true)
  _$$_RoastCopyWith<_$_Roast> get copyWith =>
      throw _privateConstructorUsedError;
}
