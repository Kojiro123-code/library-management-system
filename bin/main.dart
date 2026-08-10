import 'package:library_management_system/services/user_service.dart';

void main() async {
  final service = UserService();

  final user = await service.login(
    username: "admin",
    password: "1234",
  );

  if (user != null) {
    print("✅ Login Successful!");
    print("Name: ${user.name}");
    print("Username: ${user.username}");
    print("Role: ${user.role.name}");
  } else {
    print("❌ Invalid username or password.");
  }
}