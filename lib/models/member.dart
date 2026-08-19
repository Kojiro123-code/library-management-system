import 'person.dart';

class Member extends Person {
  String phone;
  String email;

  Member({
    int? id,
    required String name,
    required this.phone,
    required this.email,
  }) : super(
          id: id,
          name: name,
        );

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      id: int.parse(json['id'].toString()),
      name: json['name'].toString(),
      phone: json['phone'].toString(),
      email: json['email'].toString(),
    );
  }

  Map<String, dynamic> toCreateJson() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'email': email,
    };
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'email': email,
    };
  }
}