import 'person.dart';

enum UserRole { admin, user }

class User extends Person {
  final String username;
  final String password;
  final UserRole role;

  User({
    required int id,
    required String name,
    required this.username,
    required this.password,
    required this.role,
  }) : super(id: id, name: name);

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      username: json['username'],
      password: json['password'],
      role: json['role'] == 'admin' ? UserRole.admin : UserRole.user,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'username': username,
      'password': password,
      'role': role.name,
    };
  }
}
