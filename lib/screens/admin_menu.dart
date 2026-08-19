import 'dart:io';

import 'book_screen.dart';
import 'category_screen.dart';
import 'member_screen.dart';
import 'borrowing_screen.dart';

class AdminMenu {
  final BookScreen _bookScreen = BookScreen();
  final CategoryScreen _categoryScreen = CategoryScreen();
  final MemberScreen _memberScreen = MemberScreen();
  final BorrowingScreen _borrowingScreen = BorrowingScreen();

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
          await _categoryScreen.show();
          break;

        case '3':
          await _memberScreen.show();
          break;

        case '4':
          await _borrowingScreen.show();
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