import 'package:library_management_system/services/category_service.dart';

void main() async {
  final service = CategoryService();

  final success = await service.deleteCategory(
    "8uwOq8QoK1w",
  );

  if (success) {
    print("✅ Category Deleted Successfully!");
  } else {
    print("❌ Delete Failed");
  }
}