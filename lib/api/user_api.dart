import 'package:deep_scan_app/api/dio/_dio.dart';
import 'package:deep_scan_app/api/dio/api_client.dart';
import 'package:deep_scan_app/models/dio/dio_model.dart';
import 'package:deep_scan_app/api/dio/method_type.dart';
import 'package:deep_scan_app/models/user/user_model.dart';

class UserApi {
  final DioClient _dioClient = DioClient();

  @override
  Future<ApiResponse<ListResponse<UserModel>>> fetchUsers() async {
    return await _dioClient.request(
        method: MethodType.get,
        path: 'discover/tv',
        fromJson: (json) => ListResponse<UserModel>.fromJson(
          json,
              (json) =>
                  UserModel.fromJson(json as Map<String, dynamic>),
        ));
  }
}