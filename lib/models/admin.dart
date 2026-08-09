import 'user.dart';


class Admin extends User {
  Admin({
    String? id,
    required String name,
    required String username,
    required String password,
  }) : super(
          id: id,
          name: name,
          username: username,
          password: password,
          role: UserRole.admin,
        );
}
