import 'package:library_management_system/models/borrowing.dart';
import 'package:library_management_system/services/borrowing_service.dart';

void main() async {
  final service = BorrowingService();

  final returnedBorrowing = Borrowing(
    id: "1",
    bookId: "1",
    memberId: "1",
    borrowDate: DateTime.parse("2026-08-10T09:00:00.000Z"),
    returnDate: DateTime.now(),
    status: BorrowStatus.returned,
  );

  final result = await service.updateBorrowing(returnedBorrowing);

  if (result != null) {
    print("✅ Book Returned Successfully!");
    print("Borrowing ID: ${result.id}");
    print("Status: ${result.status.name}");
    print("Return Date: ${result.returnDate}");
  } else {
    print("❌ Return Failed");
  }
}