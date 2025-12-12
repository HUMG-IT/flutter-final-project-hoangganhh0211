import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_project/models/expense.dart';

void main() {
  group('Expense Model', () {
    test('toJson and fromJson should be consistent', () {
      final expense = Expense(
        title: 'Cà phê',
        amount: 30000,
        categoryId: 'food',
        date: DateTime.parse('2025-12-12'),
        description: 'Cà phê buổi sáng',
      );
      final json = expense.toJson();
      final fromJson = Expense.fromJson(json);
      expect(fromJson.title, expense.title);
      expect(fromJson.amount, expense.amount);
      expect(fromJson.categoryId, expense.categoryId);
      expect(fromJson.date, expense.date);
      expect(fromJson.description, expense.description);
    });

    test('copyWith should override fields', () {
      final expense = Expense(
        title: 'Bữa trưa',
        amount: 50000,
        categoryId: 'food',
        date: DateTime.parse('2025-12-12'),
      );
      final updated = expense.copyWith(title: 'Bữa tối', amount: 70000);
      expect(updated.title, 'Bữa tối');
      expect(updated.amount, 70000);
      expect(updated.categoryId, expense.categoryId);
    });
  });
}
