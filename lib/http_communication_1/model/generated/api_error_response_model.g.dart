// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../api_error_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ApiErrorResponseModelImpl _$$ApiErrorResponseModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ApiErrorResponseModelImpl(
      errorCode: json['errorCode'] as String? ?? 'errorCode_public001',
      message: json['message'] as String? ?? '',
    );

Map<String, dynamic> _$$ApiErrorResponseModelImplToJson(
        _$ApiErrorResponseModelImpl instance) =>
    <String, dynamic>{
      'errorCode': instance.errorCode,
      'message': instance.message,
    };
