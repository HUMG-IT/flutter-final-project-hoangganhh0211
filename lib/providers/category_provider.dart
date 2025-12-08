import 'package:flutter/material.dart';
import 'package:flutter_project/models/category.dart';

class CategoryProvider extends ChangeNotifier {
  List<Category> _categories = DefaultCategories.categories;
  String? _selectedCategoryId;

  List<Category> get categories => _categories;
  String? get selectedCategoryId => _selectedCategoryId;

  Category? get selectedCategory {
    if (_selectedCategoryId == null) return null;
    return getCategoryById(_selectedCategoryId!);
  }

  Category? getCategoryById(String id) {
    try {
      return _categories.firstWhere((category) => category.id == id);
    } catch (e) {
      return null;
    }
  }

  void selectCategory(String? categoryId) {
    _selectedCategoryId = categoryId;
    notifyListeners();
  }

  void clearSelection() {
    _selectedCategoryId = null;
    notifyListeners();
  }
}
