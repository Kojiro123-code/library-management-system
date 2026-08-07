import "api_domain.dart";
import "package:http/http.dart" as http;
import 'dart:convert';
class ApiExtension {
  static const String _domain = ApiDomain.baseUrl;


  Future<dynamic> get({
    required String endPoint,
  }) async {


    final response = await http.get(
      Uri.parse('$_domain$endPoint')
    );
    return response;
  }

  Future<http.Response> post({
    required String endPoint,
    required Map<String, dynamic> body,
  }) async {
    final response = await http.post(
      Uri.parse('$_domain$endPoint'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );
    return response;
  }


  Future<http.Response> put({
    required String endPoint,
    required Map<String, dynamic> body,
  }) async {
  final response = await http.put(
    Uri.parse('$_domain$endPoint'),
    headers: {
      'Content-Type': 'application/json',
    },
    body: jsonEncode(body),
  );
  return response;
  }

  Future<http.Response> delete({
    required String endPoint,
  }) async {
    final response = await http.delete(
      Uri.parse('$_domain$endPoint'),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    return response;
  }
}