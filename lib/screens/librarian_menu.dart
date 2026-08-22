import 'dart:io';

import 'book_screen.dart';
import 'borrowing_screen.dart';

class LibrarianMenu {
  final BookScreen _bookScreen = BookScreen(isAdmin: false);
  final BorrowingScreen _borrowingScreen = BorrowingScreen();

  Future<void> show() async {
    while (true) {
      print('');
      print('======================================');
      print('           LIBRARIAN MENU');
      print('======================================');
      print('1. Manage Books');
      print('2. Manage Borrowings');
      print('3. Logout');
      print('======================================');

      stdout.write('Select an option: ');
      final choice = stdin.readLineSync()?.trim();

      switch (choice) {
        case '1':
          await _bookScreen.show();
          break;

        case '2':
          await _borrowingScreen.show();
          break;

        case '3':
          print('Logging out...');
          return;

        default:
          print('Invalid option.');
      }
    }
  }
}