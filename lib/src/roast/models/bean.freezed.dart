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

/// @nodoc
mixin _$Bean {
  String get name => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $BeanCopyWith<Bean> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BeanCopyWith<$Res> {
  factory $BeanCopyWith(Bean value, $Res Function(Bean) then) =
      _$BeanCopyWithImpl<$Res, Bean>;
  @useResult
  $Res call({String name});
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
    Object? name = null,
  }) {
    return _then(_value.copyWith(
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
  $Res call({String name});
}

/// @nodoc
class __$$_BeanCopyWithImpl<$Res> extends _$BeanCopyWithImpl<$Res, _$_Bean>
    implements _$$_BeanCopyWith<$Res> {
  __$$_BeanCopyWithImpl(_$_Bean _value, $Res Function(_$_Bean) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
  }) {
    return _then(_$_Bean(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_Bean implements _Bean {
  const _$_Bean({required this.name});

  @override
  final String name;

  @override
  String toString() {
    return 'Bean(name: $name)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Bean &&
            (identical(other.name, name) || other.name == name));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_BeanCopyWith<_$_Bean> get copyWith =>
      __$$_BeanCopyWithImpl<_$_Bean>(this, _$identity);
}

abstract class _Bean implements Bean {
  const factory _Bean({required final String name}) = _$_Bean;

  @override
  String get name;
  @override
  @JsonKey(ignore: true)
  _$$_BeanCopyWith<_$_Bean> get copyWith => throw _privateConstructorUsedError;
}
