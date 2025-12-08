import 'package:flutter/material.dart';

class Category {
  final String id;
  final String name;
  final IconData icon;
  final Color color;

  const Category({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] as String,
      name: json['name'] as String,
      icon: IconData(
        json['iconCodePoint'] as int,
        fontFamily: json['iconFontFamily'] as String?,
      ),
      color: Color(json['colorValue'] as int),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'iconCodePoint': icon.codePoint,
      'iconFontFamily': icon.fontFamily,
      // ignore: deprecated_member_use
      'colorValue': color.value,
    };
  }

  Category copyWith({
    String? id,
    String? name,
    IconData? icon,
    Color? color,
  }) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      color: color ?? this.color,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Category &&
        other.id == id &&
        other.name == name &&
        other.icon == icon &&
        other.color == color;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ icon.hashCode ^ color.hashCode;
  }

  @override
  String toString() {
    return 'Category(id: $id, name: $name)';
  }
}

class DefaultCategories {
  static final List<Category> categories = [
    const Category(
      id: 'food',
      name: 'Ăn uống',
      icon: Icons.restaurant,
      color: Colors.orange,
    ),
    const Category(
      id: 'transport',
      name: 'Di chuyển',
      icon: Icons.directions_car,
      color: Colors.blue,
    ),
    const Category(
      id: 'shopping',
      name: 'Mua sắm',
      icon: Icons.shopping_bag,
      color: Colors.pink,
    ),
    const Category(
      id: 'entertainment',
      name: 'Giải trí',
      icon: Icons.movie,
      color: Colors.purple,
    ),
    const Category(
      id: 'health',
      name: 'Sức khỏe',
      icon: Icons.local_hospital,
      color: Colors.red,
    ),
    const Category(
      id: 'education',
      name: 'Giáo dục',
      icon: Icons.school,
      color: Colors.teal,
    ),
    const Category(
      id: 'utilities',
      name: 'Tiện ích',
      icon: Icons.receipt_long,
      color: Colors.green,
    ),
    const Category(
      id: 'other',
      name: 'Khác',
      icon: Icons.category,
      color: Colors.grey,
    ),
  ];

  static Category? getCategoryById(String id) {
    try {
      return categories.firstWhere((category) => category.id == id);
    } catch (e) {
      return null;
    }
  }

  static Category? getCategoryByName(String name) {
    try {
      return categories.firstWhere((category) => category.name == name);
    } catch (e) {
      return null;
    }
  }
}
