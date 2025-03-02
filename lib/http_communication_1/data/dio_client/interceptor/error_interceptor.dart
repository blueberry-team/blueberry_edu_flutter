import 'package:blueberry_edu/http_communication_1/model/api_error_response_model.dart';
import 'package:dio/dio.dart';

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    print(
        "ErrorInterceptor(onError), ERROR: [${err.requestOptions.method}] => PATH: ${err.requestOptions.path}, error: ${err.error}");

    final errorResponse = err.response?.data != null
        ? ApiErrorResponseModel.fromJson(err.response!.data)
        : const ApiErrorResponseModel(
            errorCode: 'errorCode_public001',
            message: 'Fail',
          );
    final error = DioException(
      requestOptions: err.requestOptions,
      response: err.response,
      type: err.type,
      error: errorResponse,
    );

    handler.next(error);
  }
}
