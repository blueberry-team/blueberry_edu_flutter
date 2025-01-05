// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../talker_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TalkerModel {
  String get name => throw _privateConstructorUsedError;
  String get age => throw _privateConstructorUsedError;

  /// Create a copy of TalkerModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TalkerModelCopyWith<TalkerModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TalkerModelCopyWith<$Res> {
  factory $TalkerModelCopyWith(
          TalkerModel value, $Res Function(TalkerModel) then) =
      _$TalkerModelCopyWithImpl<$Res, TalkerModel>;
  @useResult
  $Res call({String name, String age});
}

/// @nodoc
class _$TalkerModelCopyWithImpl<$Res, $Val extends TalkerModel>
    implements $TalkerModelCopyWith<$Res> {
  _$TalkerModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TalkerModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? age = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      age: null == age
          ? _value.age
          : age // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TalkerModelImplCopyWith<$Res>
    implements $TalkerModelCopyWith<$Res> {
  factory _$$TalkerModelImplCopyWith(
          _$TalkerModelImpl value, $Res Function(_$TalkerModelImpl) then) =
      __$$TalkerModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String age});
}

/// @nodoc
class __$$TalkerModelImplCopyWithImpl<$Res>
    extends _$TalkerModelCopyWithImpl<$Res, _$TalkerModelImpl>
    implements _$$TalkerModelImplCopyWith<$Res> {
  __$$TalkerModelImplCopyWithImpl(
      _$TalkerModelImpl _value, $Res Function(_$TalkerModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of TalkerModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? age = null,
  }) {
    return _then(_$TalkerModelImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      age: null == age
          ? _value.age
          : age // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$TalkerModelImpl implements _TalkerModel {
  const _$TalkerModelImpl({required this.name, required this.age});

  @override
  final String name;
  @override
  final String age;

  @override
  String toString() {
    return 'TalkerModel(name: $name, age: $age)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TalkerModelImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.age, age) || other.age == age));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, age);

  /// Create a copy of TalkerModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TalkerModelImplCopyWith<_$TalkerModelImpl> get copyWith =>
      __$$TalkerModelImplCopyWithImpl<_$TalkerModelImpl>(this, _$identity);
}

abstract class _TalkerModel implements TalkerModel {
  const factory _TalkerModel(
      {required final String name,
      required final String age}) = _$TalkerModelImpl;

  @override
  String get name;
  @override
  String get age;

  /// Create a copy of TalkerModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TalkerModelImplCopyWith<_$TalkerModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
