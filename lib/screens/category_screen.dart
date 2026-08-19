import 'dart:io';

import '../models/category.dart';
import '../services/category_service.dart';

class CategoryScreen {
  final CategoryService _categoryService = CategoryService();

  Future<void> show() async {
    while (true) {
      print('');
      print('======================================');
      print('        CATEGORY MANAGEMENT');
      print('======================================');
      print('1. View All Categories');
      print('2. Find Category By ID');
      print('3. Add Category');
      print('4. Update Category');
      print('5. Delete Category');
      print('6. Back');
      print('======================================');

      stdout.write('Select an option: ');
      final choice = stdin.readLineSync()?.trim();

      switch (choice) {
        case '1':
          await _getAllCategories();
          break;

        case '2':
          await _getCategoryById();
          break;

        case '3':
          await _addCategory();
          break;

        case '4':
          await _updateCategory();
          break;

        case '5':
          await _deleteCategory();
          break;

        case '6':
          return;

        default:
          print('Invalid option.');
      }
    }
  }

  Future<void> _getAllCategories() async {
    final categories = await _categoryService.getCategories();

    print('');
    print('========== CATEGORIES ==========');

    if (categories.isEmpty) {
      print('No categories found.');
      return;
    }

    for (final category in categories) {
      print('---------------------------');
      print('ID: ${category.id}');
      print('Name: ${category.name}');
      print('Description: ${category.description}');
    }

    print('---------------------------');
  }

  Future<void> _getCategoryById() async {
    stdout.write('Enter Category ID: ');

    final id = int.tryParse(
      stdin.readLineSync()?.trim() ?? '',
    );

    if (id == null) {
      print('Invalid ID. Please enter a number.');
      return;
    }

    final category =
        await _categoryService.getCategoryById(id);

    if (category == null) {
      print('Category not found.');
      return;
    }

    _displayCategory(category);
  }

  Future<void> _addCategory() async {
    stdout.write('Name: ');
    final name = stdin.readLineSync()?.trim() ?? '';

    stdout.write('Description: ');
    final description =
        stdin.readLineSync()?.trim() ?? '';

    if (name.isEmpty || description.isEmpty) {
      print('Please enter valid information.');
      return;
    }

    final category = Category(
      name: name,
      description: description,
    );

    final result =
        await _categoryService.addCategory(category);

    if (result != null) {
      print('Category Added Successfully!');
      print('Generated ID: ${result.id}');
    } else {
      print('Failed to add category.');
    }
  }

  Future<void> _updateCategory() async {
    stdout.write('Enter Category ID: ');

    final id = int.tryParse(
      stdin.readLineSync()?.trim() ?? '',
    );

    if (id == null) {
      print('Invalid ID. Please enter a number.');
      return;
    }

    final existingCategory =
        await _categoryService.getCategoryById(id);

    if (existingCategory == null) {
      print('Category not found.');
      return;
    }

    stdout.write('New Name: ');
    final nameInput =
        stdin.readLineSync()?.trim();

    stdout.write('New Description: ');
    final descriptionInput =
        stdin.readLineSync()?.trim();

    final updatedCategory = Category(
      id: existingCategory.id,
      name: nameInput == null || nameInput.isEmpty
          ? existingCategory.name
          : nameInput,
      description:
          descriptionInput == null ||
                  descriptionInput.isEmpty
              ? existingCategory.description
              : descriptionInput,
    );

    final result =
        await _categoryService.updateCategory(
      updatedCategory,
    );

    if (result != null) {
      print('Category Updated Successfully!');
    } else {
      print('Update Failed.');
    }
  }

  Future<void> _deleteCategory() async {
    stdout.write('Enter Category ID: ');

    final id = int.tryParse(
      stdin.readLineSync()?.trim() ?? '',
    );

    if (id == null) {
      print('Invalid ID. Please enter a number.');
      return;
    }

    final success =
        await _categoryService.deleteCategory(id);

    if (success) {
      print('Category Deleted Successfully!');
    } else {
      print('Delete Failed.');
    }
  }

  void _displayCategory(Category category) {
    print('');
    print('========== CATEGORY ==========');
    print('ID: ${category.id}');
    print('Name: ${category.name}');
    print('Description: ${category.description}');
    print('==============================');
  }
}