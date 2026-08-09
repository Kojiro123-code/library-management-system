import 'dart:convert';

import '../api/api_end_point.dart';
import '../api/api_extension.dart';
import '../models/member.dart';

class MemberService {
  final ApiExtension _api = ApiExtension();


  Future<List<Member>> getMembers() async {
    final response = await _api.get(endPoint: 
    ApiEndPoint.members,
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);

      return data.map((item) => Member.fromJson(item))
      .toList();
    }

    return [];
  }


  Future<Member?> addMember(Member member) async {
  final response = await _api.post(
    endPoint: ApiEndPoint.members,
    body: member.toCreateJson(),
  );

  if (response.statusCode == 201) {
    return Member.fromJson(
      jsonDecode(response.body),
    );
  }

  return null;
  }



  Future<Member?> updateMember(Member member) async {
  final response = await _api.put(
    endPoint: "${ApiEndPoint.members}/${member.id}",
    body: member.toJson(),
  );

  if (response.statusCode == 200) {
    return Member.fromJson(
      jsonDecode(response.body),
    );
  }

  return null;
  }


  Future<bool> deleteMember(String id) async {
  final response = await _api.delete(
    endPoint: "${ApiEndPoint.members}/$id",
  );

  return response.statusCode == 200;
  }
}
