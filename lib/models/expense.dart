import 'package:uuid/uuid.dart';

class Expense {
  final String id;
  final String title;
  final double amount;
  final String categoryId;
  final DateTime date;
  final String? description;
  final DateTime createdAt;
  final DateTime updatedAt;

  Expense({
    String? id,
    required this.title,
    required this.amount,
    required this.categoryId,
    required this.date,
    this.description,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : id = id ?? const Uuid().v4(),
        createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
      id: json['id'] as String,
      title: json['title'] as String,
      amount: (json['amount'] as num).toDouble(),
      categoryId: json['categoryId'] as String,
      date: DateTime.parse(json['date'] as String),
      description: json['description'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'amount': amount,
      'categoryId': categoryId,
      'date': date.toIso8601String(),
      'description': description,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  Expense copyWith({
    String? id,
    String? title,
    double? amount,
    String? categoryId,
    DateTime? date,
    String? description,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Expense(
      id: id ?? this.id,
      title: title ?? this.title,
      amount: amount ?? this.amount,
      categoryId: categoryId ?? this.categoryId,
      date: date ?? this.date,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? DateTime.now(),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Expense &&
        other.id == id &&
        other.title == title &&
        other.amount == amount &&
        other.categoryId == categoryId &&
        other.date == date &&
        other.description == description;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        amount.hashCode ^
        categoryId.hashCode ^
        date.hashCode ^
        description.hashCode;
  }

  @override
  String toString() {
    return 'Expense(id: $id, title: $title, amount: $amount, categoryId: $categoryId, date: $date)';
  }
}
