import 'dart:convert';

import '../api/api_end_point.dart';
import '../api/api_extension.dart';
import '../models/book.dart';

class BookService {
  final ApiExtension _api = ApiExtension();

  Future<List<Book>> getBooks() async {
    final response = await _api.get(endPoint: ApiEndPoint.books);

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

  Future<Book?> getBookById(int id) async {
    final response = await _api.get(endPoint: "${ApiEndPoint.books}/$id");

    if (response.statusCode == 200) {
      return Book.fromJson(jsonDecode(response.body));
    }

    return null;
  }

  Future<Book?> addBook(Book book) async {
  final books = await getBooks();

  int nextId = 1;

  if (books.isNotEmpty) {
    final ids = books
        .where((book) => book.id != null)
        .map((book) => book.id!)
        .toList();

    if (ids.isNotEmpty) {
      nextId = ids.reduce((a, b) => a > b ? a : b) + 1;
    }
  }

  final newBook = Book(
    id: nextId,
    title: book.title,
    author: book.author,
    isbn: book.isbn,
    categoryId: book.categoryId,
    publishedYear: book.publishedYear,
    quantity: book.quantity,
    availableQuantity: book.availableQuantity,
  );

  final response = await _api.post(
    endPoint: ApiEndPoint.books,
    body: newBook.toCreateJson(),
  );

  if (response.statusCode == 201) {
    return Book.fromJson(
      jsonDecode(response.body),
    );
  }

  return null;
}

  Future<Book?> updateBook(Book book) async {
    final response = await _api.put(
      endPoint: "${ApiEndPoint.books}/${book.id}",
      body: book.toJson(),
    );

    if (response.statusCode == 200) {
      return Book.fromJson(
        jsonDecode(response.body)
      );
    }

    return null;
  }


  Future<bool> deleteBook(int id) async {
    final response = await _api.delete(
      endPoint: "${ApiEndPoint.books}/$id",
    );

    return response.statusCode == 200;
  }
}
