import 'package:deep_scan_app/api/dio/method_type.dart';

class ApiResponse<T> {
  T? data;
  String? statusCode;
  bool? success;
  String? statusMessage;

  ApiResponse({
    this.data,
    this.statusCode,
    this.success,
    this.statusMessage,
  });

  @override
  String toString() {
    return 'ApiResponse<$T>{data: $data, statusCode: $statusCode, success: $success, statusMessage: $statusMessage}';
  }

  factory ApiResponse.fromError(String message, String statusCode) {
    return ApiResponse(
      success: false,
      statusCode: statusCode,
      statusMessage: message,
    );
  }
}

abstract class ApiClient {
  Future<ApiResponse<T>> request<T>({
    required String path,
    required MethodType method,
    Map<String, dynamic>? payload,
    Map<String, dynamic>? queryParameters,
    T Function(Map<String, dynamic> json)? fromJson,
    bool? showLoader,
  });

  void setToken(String token);
  void removeToken();
  String handleException(Exception exception);
}
