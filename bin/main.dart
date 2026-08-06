import 'package:library_management_system/services/book_service.dart';

void main() async {
  final service = BookService();

  final books = await service.getBooks();

  for (final book in books) {
    print("ID: ${book.id}");
    print("Title: ${book.title}");
    print("Author: ${book.author}");
    print("--------------------");
  }
}