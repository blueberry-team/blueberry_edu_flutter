import 'package:blueberry_edu/freezed_1/feature/talker.dart';
import 'package:blueberry_edu/http_communication_1/data/dio_client/dio_client.dart';
import 'package:blueberry_edu/http_communication_1/data/storage/secure_storage_repository.dart';
import 'package:dio/dio.dart';

class DioInterceptor extends Interceptor {
  final RestApiClient _apiClient;
  final SecureStorageRepository _secureStorageRepository;
  bool isTokenRefresh = false;

  DioInterceptor(this._secureStorageRepository, this._apiClient);

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    talkerLog("DioInterceptor",
        "REQUEST: [${options.method}] => PATH: ${options.path}");

    // 토큰이 필요없는 public API 경로
    final publicPaths = [
      'public_your_path',
    ];

    if (!publicPaths.contains(options.path)) {
      try {
        final token = await _secureStorageRepository.readString('token');
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        } else {
          talkerError("DioInterceptor(onRequest)", "Token is null", 'error');
        }
      } catch (e) {
        talkerError(
            "DioInterceptor(onRequest)", "Error reading token: ", 'error: $e');
      }
    }

    handler.next(
        options);
  }


  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    if (response.headers.map['X-Token-Refresh-Required']?.first == 'true') {
      try {
        if (!isTokenRefresh) {
          isTokenRefresh = true;
          talkerLog("DioInterceptor(onResponse)", "try to refresh token");
          final refreshTokenResponse = await _apiClient.post(
            'auth/refresh-token',
            null,
          );

          if (refreshTokenResponse.statusCode == 200) {
            await _secureStorageRepository.writeString(
                'token', refreshTokenResponse.data['token']);
          }
          isTokenRefresh = false;
        }
      } catch (e) {
        isTokenRefresh = false;
        talkerError(
            "DioInterceptor(onResponse)", "Error refreshing token: ", e);
      }
    }
    talkerLog("DioInterceptor(onResponse)",
        "RESPONSE: [${response.statusCode}] => PATH: ${response.requestOptions.path}");
    handler.next(response);
  }

  Future<void> handleTokenRefreshError(dynamic error) async {
    if (error is DioException) {
      if (error.response?.statusCode == 500) {
        talkerError("TokenRefreshError", "Server error", error);

        return;
      }
    }
    talkerError("TokenRefreshError", "Authentication failed", error);
    await _secureStorageRepository.deleteString('token');

  }
}

