import 'package:library_management_system/services/book_service.dart';

void main() async {
  final service = BookService();

  final success = await service.deleteBook(
    "1",
  );

  if (success) {
    print("✅ Book Deleted Successfully!");
  } else {
    print("❌ Delete Failed");
  }
}