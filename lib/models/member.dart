import 'person.dart';

class Member extends Person {
  String phone;
  String email;

  Member({
    required int id,
    required String name,
    required this.phone,
    required this.email,
  }) : super(
      id: id,
      name: name,
  );



  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      email: json['email'],
    );
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
