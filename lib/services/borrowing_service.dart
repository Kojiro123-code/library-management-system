import 'dart:convert';

import '../api/api_end_point.dart';
import '../api/api_extension.dart';
import '../models/borrowing.dart';

class BorrowingService {
  final ApiExtension _api = ApiExtension();

  Future<List<Borrowing>> getBorrowings() async {
    final response = await _api.get(
      endPoint: ApiEndPoint.borrowings,
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);

      return data
          .map((item) => Borrowing.fromJson(item))
          .toList();
    }

    return [];
  }



  Future<Borrowing?> getBorrowingById(String id) async {
  final response = await _api.get(
    endPoint: "${ApiEndPoint.borrowings}/$id",
  );

  if (response.statusCode == 200) {
    return Borrowing.fromJson(
      jsonDecode(response.body),
    );
  }

  return null;
  }


  Future<Borrowing?> addBorrowing(Borrowing borrowing) async {
  final response = await _api.post(
    endPoint: ApiEndPoint.borrowings,
    body: borrowing.toCreateJson(),
  );

  if (response.statusCode == 201) {
    return Borrowing.fromJson(
      jsonDecode(response.body),
    );
  }

  return null;
  }



  Future<Borrowing?> updateBorrowing(Borrowing borrowing) async {
  final response = await _api.put(
    endPoint: "${ApiEndPoint.borrowings}/${borrowing.id}",
    body: borrowing.toJson(),
  );

  if (response.statusCode == 200) {
    return Borrowing.fromJson(
      jsonDecode(response.body),
    );
  }

  return null;
  }
}