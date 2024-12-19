import 'dart:developer';
import 'package:deep_scan_app/api/dio/api_client.dart';
import 'package:deep_scan_app/api/dio/method_type.dart';
import 'package:deep_scan_app/utils/constants.dart';
import 'package:dio/dio.dart';

class DioClient implements ApiClient {
  late Dio _client;

  DioClient() {
    _client = Dio()
      ..options.baseUrl = baseUrl
      ..interceptors.add(InterceptorsWrapper(
        onRequest: (options, handler) {
          options.queryParameters['api_key'] =
          'a91f047d8fb04af342c384642b259680';
          //TODO: this should come from an env file, never hardcode stuff like these
          return handler.next(options);
        },
      ));
  }

  @override
  void removeToken() {
    _client.options.headers.remove('Authorization');
  }

  @override
  void setToken(String token) {
    _client.options.headers['Authorization'] = 'Bearer $token';
  }

  @override
  Future<ApiResponse<T>> request<T>({
    required String path,
    required MethodType method,
    Map<String, dynamic>? payload,
    Map<String, dynamic>? queryParameters,
    T Function(Map<String, dynamic> json)? fromJson,
    bool? showLoader,
  }) async {
    ApiResponse<T> apiResponse;
    Response response;
    try {
      switch (method) {
        case MethodType.get:
          response = await _client.get(
            path,
            data: payload,
            queryParameters: queryParameters,
          );
          break;
        case MethodType.post:
          response = await _client.post(
            path,
            data: payload,
            queryParameters: queryParameters,
          );
          break;
        case MethodType.put:
          response = await _client.put(
            path,
            data: payload,
            queryParameters: queryParameters,
          );
          break;
        case MethodType.delete:
          response = await _client.delete(
            path,
            data: payload,
            queryParameters: queryParameters,
          );
          break;
        case MethodType.patch:
          response = await _client.patch(
            path,
            data: payload,
            queryParameters: queryParameters,
          );
          break;
      }


      apiResponse = ApiResponse(
        data: fromJson?.call(response.data),
        statusCode: response.statusCode.toString(),
        success: true,
      );
    } on DioException catch (e) {
      apiResponse = ApiResponse<T>.fromError(
        (e.response?.data['status_message'] ?? e.message).toString(),
        (e.response?.data?['status_code'] ?? e.response?.statusCode).toString(),
      );
    }
    // log(apiResponse.toString(), name: 'api_response');
    return apiResponse;
  }

  @override
  String handleException(Exception exception) {
    // TODO: implement handleException
    throw UnimplementedError();
  }
}