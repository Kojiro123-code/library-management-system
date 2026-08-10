import 'dart:convert';

import '../api/api_end_point.dart';
import '../api/api_extension.dart';
import '../models/user.dart';

class UserService {
  final ApiExtension _api = ApiExtension();

  Future<User?> login({
    required String username,
    required String password,
  }) async {
    final response = await _api.get(
      endPoint: ApiEndPoint.users,
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);

      for (final item in data) {
        final user = User.fromJson(item);

        if (user.username == username &&
            user.password == password) {
          return user;
        }
      }
    }

    return null;
  }
}