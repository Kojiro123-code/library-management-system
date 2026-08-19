import 'dart:io';

import 'book_screen.dart';

class AdminMenu {
  final BookScreen _bookScreen = BookScreen();

  Future<void> show() async {
    while (true) {
      print('');
      print('======================================');
      print('              ADMIN MENU');
      print('======================================');
      print('1. Manage Books');
      print('2. Manage Categories');
      print('3. Manage Member');
      print('4. Manage Borrowings');
      print('5. Logout');
      print('======================================');

      stdout.write('Select an option: ');
      final choice = stdin.readLineSync()?.trim();

      switch (choice) {
        case '1':
          await _bookScreen.show();
          break;

        case '2':
          print('Category Management is not restored yet.');
          break;

        case '3':
          print('Member Management is not restored yet.');
          break;

        case '4':
          print('Borrowing Management is not restored yet.');
          break;

        case '5':
          print('Logging out...');
          return;

        default:
          print('Invalid option.');
      }
    }
  }
}