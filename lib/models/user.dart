import 'person.dart';

enum UserRole { admin, librarian }

class User extends Person {
  final String username;
  final String password;
  final UserRole role;

  User({
    int? id,
    required String name,
    required this.username,
    required this.password,
    required this.role,
  }) : super(
          id: id,
          name: name,
        );

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] is int
          ? json['id'] as int
          : int.tryParse(json['id'].toString()),
      name: json['name'].toString(),
      username: json['username'].toString(),
      password: json['password'].toString(),
      role: json['role'] == 'admin'
          ? UserRole.admin
          : UserRole.librarian,
    );
  }

  Map<String, dynamic> toCreateJson() {
    return {
      'name': name,
      'username': username,
      'password': password,
      'role': role.name,
    };
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