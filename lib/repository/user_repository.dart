import 'package:deep_scan_app/api/user_api.dart';
import 'package:deep_scan_app/models/user/user_model.dart';

class UserRepository {
  final UserApi userApi;

  UserRepository(this.userApi);

  Future<List<UserModel>> getUsers() async {
    final response = await userApi.fetchUsers();
    return response.data?.results ?? [];
  }
}
