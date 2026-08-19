import 'dart:io';

import '../models/borrowing.dart';
import '../services/borrowing_service.dart';

class BorrowingScreen {
  final BorrowingService _borrowingService = BorrowingService();

  Future<void> show() async {
    while (true) {
      print('');
      print('======================================');
      print('        BORROWING MANAGEMENT');
      print('======================================');
      print('1. View All Borrowings');
      print('2. Find Borrowing By ID');
      print('3. Add Borrowing');
      print('4. Update Borrowing');
      print('5. Delete Borrowing');
      print('6. Back');
      print('======================================');

      stdout.write('Select an option: ');
      final choice = stdin.readLineSync()?.trim();

      switch (choice) {
        case '1':
          await _getAllBorrowings();
          break;

        case '2':
          await _getBorrowingById();
          break;

        case '3':
          await _addBorrowing();
          break;

        case '4':
          await _updateBorrowing();
          break;

        case '5':
          await _deleteBorrowing();
          break;

        case '6':
          return;

        default:
          print('Invalid option.');
      }
    }
  }

  Future<void> _getAllBorrowings() async {
    final borrowings = await _borrowingService.getBorrowings();

    print('');
    print('========== BORROWINGS ==========');

    if (borrowings.isEmpty) {
      print('No borrowings found.');
      return;
    }

    for (final borrowing in borrowings) {
      print('---------------------------');
      print('ID: ${borrowing.id}');
      print('Book ID: ${borrowing.bookId}');
      print('Member ID: ${borrowing.memberId}');
      print('Borrow Date: ${borrowing.borrowDate}');
      print('Return Date: ${borrowing.returnDate ?? 'Not returned'}');
      print('Status: ${borrowing.status.name}');
    }

    print('---------------------------');
  }

  Future<void> _getBorrowingById() async {
    stdout.write('Enter Borrowing ID: ');

    final id = int.tryParse(
      stdin.readLineSync()?.trim() ?? '',
    );

    if (id == null) {
      print('Invalid ID. Please enter a number.');
      return;
    }

    final borrowing =
        await _borrowingService.getBorrowingById(id);

    if (borrowing == null) {
      print('Borrowing not found.');
      return;
    }

    _displayBorrowing(borrowing);
  }

  Future<void> _addBorrowing() async {
    stdout.write('Book ID: ');

    final bookId = int.tryParse(
      stdin.readLineSync()?.trim() ?? '',
    );

    stdout.write('Member ID: ');

    final memberId = int.tryParse(
      stdin.readLineSync()?.trim() ?? '',
    );

    if (bookId == null || memberId == null) {
      print('Please enter valid numeric IDs.');
      return;
    }

    final borrowing = Borrowing(
      bookId: bookId,
      memberId: memberId,
      borrowDate: DateTime.now(),
      returnDate: null,
      status: BorrowStatus.borrowed,
    );

    final result =
        await _borrowingService.addBorrowing(borrowing);

    if (result != null) {
      print('Borrowing Added Successfully!');
      print('Generated ID: ${result.id}');
    } else {
      print('Failed to add borrowing.');
    }
  }

  Future<void> _updateBorrowing() async {
    stdout.write('Enter Borrowing ID: ');

    final id = int.tryParse(
      stdin.readLineSync()?.trim() ?? '',
    );

    if (id == null) {
      print('Invalid ID. Please enter a number.');
      return;
    }

    final existingBorrowing =
        await _borrowingService.getBorrowingById(id);

    if (existingBorrowing == null) {
      print('Borrowing not found.');
      return;
    }

    print('');
    print('Current status: ${existingBorrowing.status.name}');
    print('1. Borrowed');
    print('2. Returned');

    stdout.write('Select new status: ');
    final statusChoice = stdin.readLineSync()?.trim();

    BorrowStatus newStatus;

    if (statusChoice == '2') {
      newStatus = BorrowStatus.returned;
    } else if (statusChoice == '1') {
      newStatus = BorrowStatus.borrowed;
    } else {
      print('Invalid status.');
      return;
    }

    DateTime? newReturnDate = existingBorrowing.returnDate;

    if (newStatus == BorrowStatus.returned &&
        newReturnDate == null) {
      newReturnDate = DateTime.now();
    }

    if (newStatus == BorrowStatus.borrowed) {
      newReturnDate = null;
    }

    final updatedBorrowing = Borrowing(
      id: existingBorrowing.id,
      bookId: existingBorrowing.bookId,
      memberId: existingBorrowing.memberId,
      borrowDate: existingBorrowing.borrowDate,
      returnDate: newReturnDate,
      status: newStatus,
    );

    final result =
        await _borrowingService.updateBorrowing(
      updatedBorrowing,
    );

    if (result != null) {
      print('Borrowing Updated Successfully!');
    } else {
      print('Update Failed.');
    }
  }

  Future<void> _deleteBorrowing() async {
    stdout.write('Enter Borrowing ID: ');

    final id = int.tryParse(
      stdin.readLineSync()?.trim() ?? '',
    );

    if (id == null) {
      print('Invalid ID. Please enter a number.');
      return;
    }

    final success =
        await _borrowingService.deleteBorrowing(id);

    if (success) {
      print('Borrowing Deleted Successfully!');
    } else {
      print('Delete Failed.');
    }
  }

  void _displayBorrowing(Borrowing borrowing) {
    print('');
    print('========== BORROWING ==========');
    print('ID: ${borrowing.id}');
    print('Book ID: ${borrowing.bookId}');
    print('Member ID: ${borrowing.memberId}');
    print('Borrow Date: ${borrowing.borrowDate}');
    print(
      'Return Date: '
      '${borrowing.returnDate ?? 'Not returned'}',
    );
    print('Status: ${borrowing.status.name}');
    print('===============================');
  }
}