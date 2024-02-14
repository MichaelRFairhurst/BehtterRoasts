// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bean.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Bean _$BeanFromJson(Map<String, dynamic> json) {
  return _Bean.fromJson(json);
}

/// @nodoc
mixin _$Bean {
  @JsonKey(includeFromJson: false, includeToJson: false)
  String? get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BeanCopyWith<Bean> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BeanCopyWith<$Res> {
  factory $BeanCopyWith(Bean value, $Res Function(Bean) then) =
      _$BeanCopyWithImpl<$Res, Bean>;
  @useResult
  $Res call(
      {@JsonKey(includeFromJson: false, includeToJson: false) String? id,
      String name});
}

/// @nodoc
class _$BeanCopyWithImpl<$Res, $Val extends Bean>
    implements $BeanCopyWith<$Res> {
  _$BeanCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_BeanCopyWith<$Res> implements $BeanCopyWith<$Res> {
  factory _$$_BeanCopyWith(_$_Bean value, $Res Function(_$_Bean) then) =
      __$$_BeanCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(includeFromJson: false, includeToJson: false) String? id,
      String name});
}

/// @nodoc
class __$$_BeanCopyWithImpl<$Res> extends _$BeanCopyWithImpl<$Res, _$_Bean>
    implements _$$_BeanCopyWith<$Res> {
  __$$_BeanCopyWithImpl(_$_Bean _value, $Res Function(_$_Bean) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = null,
  }) {
    return _then(_$_Bean(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Bean implements _Bean {
  const _$_Bean(
      {@JsonKey(includeFromJson: false, includeToJson: false) this.id,
      required this.name});

  factory _$_Bean.fromJson(Map<String, dynamic> json) => _$$_BeanFromJson(json);

  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final String? id;
  @override
  final String name;

  @override
  String toString() {
    return 'Bean(id: $id, name: $name)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Bean &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_BeanCopyWith<_$_Bean> get copyWith =>
      __$$_BeanCopyWithImpl<_$_Bean>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_BeanToJson(
      this,
    );
  }
}

abstract class _Bean implements Bean {
  const factory _Bean(
      {@JsonKey(includeFromJson: false, includeToJson: false) final String? id,
      required final String name}) = _$_Bean;

  factory _Bean.fromJson(Map<String, dynamic> json) = _$_Bean.fromJson;

  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  String? get id;
  @override
  String get name;
  @override
  @JsonKey(ignore: true)
  _$$_BeanCopyWith<_$_Bean> get copyWith => throw _privateConstructorUsedError;
}
