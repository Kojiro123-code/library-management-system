import 'dart:convert';

import '../api/api_end_point.dart';
import '../api/api_extension.dart';
import '../models/category.dart';

class CategoryService {
  final ApiExtension _api = ApiExtension();

  Future<List<Category>> getCategories() async {
    final response = await _api.get(
      endPoint: ApiEndPoint.categories,
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);

      return data
          .map((item) => Category.fromJson(item))
          .toList();
    }

    return [];
  }

  Future<Category?> getCategoryById(int id) async {
    final response = await _api.get(
      endPoint: "${ApiEndPoint.categories}/$id",
    );

    if (response.statusCode == 200) {
      return Category.fromJson(
        jsonDecode(response.body),
      );
    }

    return null;
  }

  Future<Category?> addCategory(Category category) async {
    final categories = await getCategories();

    int nextId = 1;

    if (categories.isNotEmpty) {
      final ids = categories
          .where((category) => category.id != null)
          .map((category) => category.id!)
          .toList();

      if (ids.isNotEmpty) {
        nextId =
            ids.reduce((a, b) => a > b ? a : b) + 1;
      }
    }

    final newCategory = Category(
      id: nextId,
      name: category.name,
      description: category.description,
    );

    final response = await _api.post(
      endPoint: ApiEndPoint.categories,
      body: newCategory.toCreateJson(),
    );

    if (response.statusCode == 201) {
      return Category.fromJson(
        jsonDecode(response.body),
      );
    }

    return null;
  }

  Future<Category?> updateCategory(Category category) async {
    final response = await _api.put(
      endPoint: "${ApiEndPoint.categories}/${category.id}",
      body: category.toJson(),
    );

    if (response.statusCode == 200) {
      return Category.fromJson(
        jsonDecode(response.body),
      );
    }

    return null;
  }

  Future<bool> deleteCategory(int id) async {
    final response = await _api.delete(
      endPoint: "${ApiEndPoint.categories}/$id",
    );

    return response.statusCode == 200;
  }
}