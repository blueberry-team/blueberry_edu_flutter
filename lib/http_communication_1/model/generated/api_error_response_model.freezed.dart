// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../api_error_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ApiErrorResponseModel _$ApiErrorResponseModelFromJson(
    Map<String, dynamic> json) {
  return _ApiErrorResponseModel.fromJson(json);
}

/// @nodoc
mixin _$ApiErrorResponseModel {
  String get errorCode => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;

  /// Serializes this ApiErrorResponseModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ApiErrorResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ApiErrorResponseModelCopyWith<ApiErrorResponseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApiErrorResponseModelCopyWith<$Res> {
  factory $ApiErrorResponseModelCopyWith(ApiErrorResponseModel value,
          $Res Function(ApiErrorResponseModel) then) =
      _$ApiErrorResponseModelCopyWithImpl<$Res, ApiErrorResponseModel>;
  @useResult
  $Res call({String errorCode, String message});
}

/// @nodoc
class _$ApiErrorResponseModelCopyWithImpl<$Res,
        $Val extends ApiErrorResponseModel>
    implements $ApiErrorResponseModelCopyWith<$Res> {
  _$ApiErrorResponseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ApiErrorResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? errorCode = null,
    Object? message = null,
  }) {
    return _then(_value.copyWith(
      errorCode: null == errorCode
          ? _value.errorCode
          : errorCode // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ApiErrorResponseModelImplCopyWith<$Res>
    implements $ApiErrorResponseModelCopyWith<$Res> {
  factory _$$ApiErrorResponseModelImplCopyWith(
          _$ApiErrorResponseModelImpl value,
          $Res Function(_$ApiErrorResponseModelImpl) then) =
      __$$ApiErrorResponseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String errorCode, String message});
}

/// @nodoc
class __$$ApiErrorResponseModelImplCopyWithImpl<$Res>
    extends _$ApiErrorResponseModelCopyWithImpl<$Res,
        _$ApiErrorResponseModelImpl>
    implements _$$ApiErrorResponseModelImplCopyWith<$Res> {
  __$$ApiErrorResponseModelImplCopyWithImpl(_$ApiErrorResponseModelImpl _value,
      $Res Function(_$ApiErrorResponseModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of ApiErrorResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? errorCode = null,
    Object? message = null,
  }) {
    return _then(_$ApiErrorResponseModelImpl(
      errorCode: null == errorCode
          ? _value.errorCode
          : errorCode // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ApiErrorResponseModelImpl implements _ApiErrorResponseModel {
  const _$ApiErrorResponseModelImpl(
      {this.errorCode = 'errorCode_public001', this.message = ''});

  factory _$ApiErrorResponseModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ApiErrorResponseModelImplFromJson(json);

  @override
  @JsonKey()
  final String errorCode;
  @override
  @JsonKey()
  final String message;

  @override
  String toString() {
    return 'ApiErrorResponseModel(errorCode: $errorCode, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ApiErrorResponseModelImpl &&
            (identical(other.errorCode, errorCode) ||
                other.errorCode == errorCode) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, errorCode, message);

  /// Create a copy of ApiErrorResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ApiErrorResponseModelImplCopyWith<_$ApiErrorResponseModelImpl>
      get copyWith => __$$ApiErrorResponseModelImplCopyWithImpl<
          _$ApiErrorResponseModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ApiErrorResponseModelImplToJson(
      this,
    );
  }
}

abstract class _ApiErrorResponseModel implements ApiErrorResponseModel {
  const factory _ApiErrorResponseModel(
      {final String errorCode,
      final String message}) = _$ApiErrorResponseModelImpl;

  factory _ApiErrorResponseModel.fromJson(Map<String, dynamic> json) =
      _$ApiErrorResponseModelImpl.fromJson;

  @override
  String get errorCode;
  @override
  String get message;

  /// Create a copy of ApiErrorResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ApiErrorResponseModelImplCopyWith<_$ApiErrorResponseModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
