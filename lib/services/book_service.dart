import 'dart:convert';

import '../api/api_end_point.dart';
import '../api/api_extension.dart';
import '../models/book.dart';

class BookService {
  final ApiExtension _api = ApiExtension();

  Future<List<Book>> getBooks() async {
    final response = await _api.get(
      endPoint: ApiEndPoint.books,
    );

    print("Status Code: ${response.statusCode}");
    print("Response Body: ${response.body}");

    final List<dynamic> data = jsonDecode(response.body);

    List<Book> books = [];

    for (var item in data) {
      print(item);
      books.add(Book.fromJson(item));
    }

    return books;
  }
}
