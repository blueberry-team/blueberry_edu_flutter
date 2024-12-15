// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../sign_up_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SignUpDtoImpl _$$SignUpDtoImplFromJson(Map<String, dynamic> json) =>
    _$SignUpDtoImpl(
      email: json['email'] as String,
      id: json['id'] as String?,
      password: json['password'] as String,
      name: json['name'] as String,
      activity: json['activity'] as String,
    );

Map<String, dynamic> _$$SignUpDtoImplToJson(_$SignUpDtoImpl instance) =>
    <String, dynamic>{
      'email': instance.email,
      'id': instance.id,
      'password': instance.password,
      'name': instance.name,
      'activity': instance.activity,
    };
