// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'counter_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CounterModel {
  int get value => throw _privateConstructorUsedError;

  /// Create a copy of CounterModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CounterModelCopyWith<CounterModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CounterModelCopyWith<$Res> {
  factory $CounterModelCopyWith(
          CounterModel value, $Res Function(CounterModel) then) =
      _$CounterModelCopyWithImpl<$Res, CounterModel>;
  @useResult
  $Res call({int value});
}

/// @nodoc
class _$CounterModelCopyWithImpl<$Res, $Val extends CounterModel>
    implements $CounterModelCopyWith<$Res> {
  _$CounterModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CounterModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
  }) {
    return _then(_value.copyWith(
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CounterModelImplCopyWith<$Res>
    implements $CounterModelCopyWith<$Res> {
  factory _$$CounterModelImplCopyWith(
          _$CounterModelImpl value, $Res Function(_$CounterModelImpl) then) =
      __$$CounterModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int value});
}

/// @nodoc
class __$$CounterModelImplCopyWithImpl<$Res>
    extends _$CounterModelCopyWithImpl<$Res, _$CounterModelImpl>
    implements _$$CounterModelImplCopyWith<$Res> {
  __$$CounterModelImplCopyWithImpl(
      _$CounterModelImpl _value, $Res Function(_$CounterModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of CounterModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
  }) {
    return _then(_$CounterModelImpl(
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$CounterModelImpl implements _CounterModel {
  const _$CounterModelImpl({required this.value});

  @override
  final int value;

  @override
  String toString() {
    return 'CounterModel(value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CounterModelImpl &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  /// Create a copy of CounterModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CounterModelImplCopyWith<_$CounterModelImpl> get copyWith =>
      __$$CounterModelImplCopyWithImpl<_$CounterModelImpl>(this, _$identity);
}

abstract class _CounterModel implements CounterModel {
  const factory _CounterModel({required final int value}) = _$CounterModelImpl;

  @override
  int get value;

  /// Create a copy of CounterModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CounterModelImplCopyWith<_$CounterModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
