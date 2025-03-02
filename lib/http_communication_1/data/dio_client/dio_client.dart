import 'package:blueberry_edu/http_communication_1/data/dio_client/interceptor/dio_interceptor.dart';
import 'package:blueberry_edu/http_communication_1/data/dio_client/interceptor/error_interceptor.dart';
import 'package:blueberry_edu/http_communication_1/data/storage/secure_storage_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';

part 'generated/dio_client.g.dart';

final restApiClientProvider = Provider<RestApiClient>((ref) {
  final dio = Dio(BaseOptions(
      baseUrl: dotenv.get('BASE_TEST_URL'), contentType: 'application/json'));

  final client = RestApiClient(dio);

  dio.interceptors.addAll([
    DioInterceptor(ref.read(secureStorageRepositoryProvider), client),
    ErrorInterceptor(),
  ]);

  return client;
});

@RestApi()
abstract class RestApiClient {
  factory RestApiClient(Dio dio) = _RestApiClient;

  @GET('{endpoint}')
  Future<dynamic> getSingleQuery(@Path('endpoint') String endpoint,
      @Query('query') String query, @Body() dynamic body);

  @GET('{endpoint}')
  Future<dynamic> getMultipleMapQuery(@Path('endpoint') String endpoint,
      @Queries() Map<String, dynamic> queries, @Body() dynamic body);

  @GET('{endpoint}')
  Future<dynamic> getMultipleListQuery(
    @Path('endpoint') String endpoint,
    @Query('query') List<String> query,
  );

  @POST('{endpoint}')
  Future<dynamic> post(@Path('endpoint') String endpoint, @Body() dynamic body);

  @PUT('{endpoint}')
  Future<dynamic> put(@Path('endpoint') String endpoint, @Body() dynamic body);

  @DELETE('{endpoint}')
  Future<dynamic> delete(
      @Path('endpoint') String endpoint, @Body() dynamic body);
}
