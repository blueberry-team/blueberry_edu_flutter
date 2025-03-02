import 'dart:convert';
import 'package:blueberry_edu/http_communication_1/data/http_client/http_exception/custom_http_exception.dart';
import 'package:blueberry_edu/http_communication_1/model/api_error_response_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class HttpClient {
  Future<dynamic> get(String endpoint, dynamic body);
  Future<dynamic> post(String endpoint, dynamic body);
  Future<dynamic> put(String endpoint, dynamic body);
  Future<dynamic> delete(String endpoint, dynamic body);
}

// http_client_provider.dart
final httpClientProvider = Provider<HttpClient>((ref) {
  return HttpClientImpl(
    http.Client(),
    headers: {'Content-Type': 'application/json'},
  );
});

class HttpClientImpl implements HttpClient {
  final http.Client _client;
  final String baseUrl;
  final Map<String, String> _headers;

  HttpClientImpl(
    this._client, {
    String? baseUrl,
    Map<String, String>? headers,
  })  : baseUrl = baseUrl ?? dotenv.get('BASE_TEST_URL'),
        _headers = headers ?? {'Content-Type': 'application/json'};

  @override
  Future<dynamic> get(String endpoint, dynamic body) async {
    final response = await _client.get(
      Uri.parse('$baseUrl$endpoint'),
      headers: _headers,
    );
    return _handleResponse(response);
  }

  @override
  Future<dynamic> post(String endpoint, dynamic body) async {
    final response = await _client.post(
      Uri.parse('$baseUrl$endpoint'),
      headers: _headers,
      body: jsonEncode(body),
    );
    return _handleResponse(response);
  }

  @override
  Future<dynamic> put(String endpoint, dynamic body) async {
    final response = await _client.put(
      Uri.parse('$baseUrl$endpoint'),
      headers: _headers,
      body: jsonEncode(body),
    );
    return _handleResponse(response);
  }

  @override
  Future<dynamic> delete(String endpoint, dynamic body) async {
    final response = await _client.delete(
      Uri.parse('$baseUrl$endpoint'),
      headers: _headers,
      body: jsonEncode(body),
    );
    return _handleResponse(response);
  }

  Future<dynamic> _handleResponse(http.Response response) async {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonDecode(response.body);
    } else {
      final errorResponse = _parseErrorResponse(response);
      throw CustomHttpException(
        errorResponse: errorResponse,
        statusCode: response.statusCode,
      );
    }
  }

    ApiErrorResponseModel _parseErrorResponse(http.Response response) {
    try {
      final bodyMap = jsonDecode(response.body);
      return ApiErrorResponseModel.fromJson(bodyMap);
    } catch (e) {
      return const ApiErrorResponseModel(
        errorCode: 'error_parsing_failed',
        message: 'Failed to parse error response',
      );
    }
  }
}
