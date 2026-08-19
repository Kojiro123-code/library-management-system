import 'dart:io';

import '../models/book.dart';
import '../services/book_service.dart';

class BookScreen {
  final BookService _bookService = BookService();

  Future<void> show() async {
    while (true) {
      print('');
      print('======================================');
      print('           BOOK MANAGEMENT');
      print('======================================');
      print('1. View All Books');
      print('2. Find Book By ID');
      print('3. Add Book');
      print('4. Update Book');
      print('5. Delete Book');
      print('6. Back');
      print('======================================');

      stdout.write('Select an option: ');
      final choice = stdin.readLineSync()?.trim();

      switch (choice) {
        case '1':
          await _getAllBooks();
          break;

        case '2':
          await _getBookById();
          break;

        case '3':
          await _addBook();
          break;

        case '4':
          await _updateBook();
          break;

        case '5':
          await _deleteBook();
          break;

        case '6':
          return;

        default:
          print(' Invalid option.');
      }
    }
  }

  Future<void> _getAllBooks() async {
    final books = await _bookService.getBooks();

    print('');
    print('========== BOOKS ==========');

    if (books.isEmpty) {
      print('No books found.');
      return;
    }

    for (final book in books) {
      print('---------------------------');
      print('ID: ${book.id}');
      print('Title: ${book.title}');
      print('Author: ${book.author}');
      print('ISBN: ${book.isbn}');
      print('Category ID: ${book.categoryId}');
      print('Published Year: ${book.publishedYear}');
      print('Quantity: ${book.quantity}');
      print('Available: ${book.availableQuantity}');
    }

    print('---------------------------');
  }

  Future<void> _getBookById() async {
    stdout.write('Enter Book ID: ');

    final id = int.tryParse(
      stdin.readLineSync()?.trim() ?? '',
    );

    if (id == null) {
      print(' Invalid ID. Please enter a number.');
      return;
    }

    final book = await _bookService.getBookById(id);

    if (book == null) {
      print(' Book not found.');
      return;
    }

    _displayBook(book);
  }

  Future<void> _addBook() async {
    stdout.write('Title: ');
    final title = stdin.readLineSync()?.trim() ?? '';

    stdout.write('Author: ');
    final author = stdin.readLineSync()?.trim() ?? '';

    stdout.write('ISBN: ');
    final isbn = stdin.readLineSync()?.trim() ?? '';

    stdout.write('Category ID: ');
    final categoryId = int.tryParse(
      stdin.readLineSync()?.trim() ?? '',
    );

    stdout.write('Published Year: ');
    final publishedYear = int.tryParse(
      stdin.readLineSync()?.trim() ?? '',
    );

    stdout.write('Quantity: ');
    final quantity = int.tryParse(
      stdin.readLineSync()?.trim() ?? '',
    );

    if (title.isEmpty ||
        author.isEmpty ||
        isbn.isEmpty ||
        categoryId == null ||
        publishedYear == null ||
        quantity == null) {
      print(' Please enter valid information.');
      return;
    }

    final book = Book(
      title: title,
      author: author,
      isbn: isbn,
      categoryId: categoryId,
      publishedYear: publishedYear,
      quantity: quantity,
      availableQuantity: quantity,
    );

    final result = await _bookService.addBook(book);

    if (result != null) {
      print(' Book Added Successfully!');
      print('Generated ID: ${result.id}');
    } else {
      print(' Failed to add book.');
    }
  }

  Future<void> _updateBook() async {
    stdout.write('Enter Book ID: ');

    final id = int.tryParse(
      stdin.readLineSync()?.trim() ?? '',
    );

    if (id == null) {
      print(' Invalid ID. Please enter a number.');
      return;
    }

    final existingBook = await _bookService.getBookById(id);

    if (existingBook == null) {
      print(' Book not found.');
      return;
    }

    stdout.write('New Title: ');
    final titleInput = stdin.readLineSync()?.trim();

    stdout.write('New Author: ');
    final authorInput = stdin.readLineSync()?.trim();

    stdout.write('New ISBN: ');
    final isbnInput = stdin.readLineSync()?.trim();

    final updatedBook = Book(
      id: existingBook.id,
      title: titleInput == null || titleInput.isEmpty
          ? existingBook.title
          : titleInput,
      author: authorInput == null || authorInput.isEmpty
          ? existingBook.author
          : authorInput,
      isbn: isbnInput == null || isbnInput.isEmpty
          ? existingBook.isbn
          : isbnInput,
      categoryId: existingBook.categoryId,
      publishedYear: existingBook.publishedYear,
      quantity: existingBook.quantity,
      availableQuantity: existingBook.availableQuantity,
    );

    final result = await _bookService.updateBook(updatedBook);

    if (result != null) {
      print(' Book Updated Successfully!');
    } else {
      print(' Update Failed.');
    }
  }

  Future<void> _deleteBook() async {
    stdout.write('Enter Book ID: ');

    final id = int.tryParse(
      stdin.readLineSync()?.trim() ?? '',
    );

    if (id == null) {
      print(' Invalid ID. Please enter a number.');
      return;
    }

    final success = await _bookService.deleteBook(id);

    if (success) {
      print(' Book Deleted Successfully!');
    } else {
      print(' Delete Failed.');
    }
  }

  void _displayBook(Book book) {
    print('');
    print('========== BOOK ==========');
    print('ID: ${book.id}');
    print('Title: ${book.title}');
    print('Author: ${book.author}');
    print('ISBN: ${book.isbn}');
    print('Category ID: ${book.categoryId}');
    print('Published Year: ${book.publishedYear}');
    print('Quantity: ${book.quantity}');
    print('Available: ${book.availableQuantity}');
    print('==========================');
  }
}