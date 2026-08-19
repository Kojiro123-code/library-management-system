import 'dart:io';

import '../models/user.dart';
import '../services/user_service.dart';
import 'admin_menu.dart';
import 'librarian_menu.dart';

class LoginScreen {
  final UserService _userService = UserService();

  Future<void> show() async {
    print('');
    print('======================================');
    print('       LIBRARY MANAGEMENT SYSTEM');
    print('======================================');
    print('                  LOGIN');
    print('======================================');

    stdout.write('Username: ');
    final username = stdin.readLineSync()?.trim() ?? '';

    stdout.write('Password: ');
    final password = stdin.readLineSync()?.trim() ?? '';

    print('');
    print('Logging in...');

    final user = await _userService.login(
      username: username,
      password: password,
    );

    if (user == null) {
      print('');
      print('Invalid username or password.');
      return;
    }

    print('');
    print('Login Successful!');
    print('Name: ${user.name}');
    print('Username: ${user.username}');
    print('Role: ${user.role.name}');

    if (user.role == UserRole.admin) {
  final adminMenu = AdminMenu();
  await adminMenu.show();
} else if (user.role == UserRole.librarian) {
  final librarianMenu = LibrarianMenu();
  await librarianMenu.show();
}
  }
}