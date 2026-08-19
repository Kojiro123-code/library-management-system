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

  Future<Borrowing?> getBorrowingById(int id) async {
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

  Future<Borrowing?> addBorrowing(
    Borrowing borrowing,
  ) async {
    final borrowings = await getBorrowings();

    int nextId = 1;

    if (borrowings.isNotEmpty) {
      final ids = borrowings
          .where((borrowing) => borrowing.id != null)
          .map((borrowing) => borrowing.id!)
          .toList();

      if (ids.isNotEmpty) {
        nextId =
            ids.reduce((a, b) => a > b ? a : b) + 1;
      }
    }

    final newBorrowing = Borrowing(
      id: nextId,
      bookId: borrowing.bookId,
      memberId: borrowing.memberId,
      borrowDate: borrowing.borrowDate,
      returnDate: borrowing.returnDate,
      status: borrowing.status,
    );

    final response = await _api.post(
      endPoint: ApiEndPoint.borrowings,
      body: newBorrowing.toCreateJson(),
    );

    if (response.statusCode == 201) {
      return Borrowing.fromJson(
        jsonDecode(response.body),
      );
    }

    return null;
  }

  Future<Borrowing?> updateBorrowing(
    Borrowing borrowing,
  ) async {
    final response = await _api.put(
      endPoint:
          "${ApiEndPoint.borrowings}/${borrowing.id}",
      body: borrowing.toJson(),
    );

    if (response.statusCode == 200) {
      return Borrowing.fromJson(
        jsonDecode(response.body),
      );
    }

    return null;
  }

  Future<bool> deleteBorrowing(int id) async {
    final response = await _api.delete(
      endPoint: "${ApiEndPoint.borrowings}/$id",
    );

    return response.statusCode == 200;
  }
}