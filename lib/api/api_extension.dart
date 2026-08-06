import "api_domain.dart";
import "package:http/http.dart" as http;
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
}