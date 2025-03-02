import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/api_error_response_model.freezed.dart';
part 'generated/api_error_response_model.g.dart';

@freezed
class ApiErrorResponseModel with _$ApiErrorResponseModel {
  const factory ApiErrorResponseModel({
    @Default('errorCode_public001') String errorCode,
    @Default('') String message,
  }) = _ApiErrorResponseModel;

  factory ApiErrorResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ApiErrorResponseModelFromJson(json);
}
