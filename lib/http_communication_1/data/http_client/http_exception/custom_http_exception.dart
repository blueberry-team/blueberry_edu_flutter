import 'package:blueberry_edu/http_communication_1/model/api_error_response_model.dart';

class CustomHttpException implements Exception {
  final ApiErrorResponseModel errorResponse;
  final int? statusCode;

  CustomHttpException({
    required this.errorResponse,
    this.statusCode,
  });
}
