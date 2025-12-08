import 'package:localstore/localstore.dart';
import 'package:flutter_project/models/expense.dart';

class LocalstoreService {
  final _db = Localstore.instance;
  final String _collectionName = 'expenses';

  Future<void> saveExpense(Expense expense) async {
    await _db.collection(_collectionName).doc(expense.id).set(expense.toJson());
  }

  Future<void> updateExpense(Expense expense) async {
    final updatedExpense = expense.copyWith(updatedAt: DateTime.now());
    await _db
        .collection(_collectionName)
        .doc(updatedExpense.id)
        .set(updatedExpense.toJson());
  }

  Future<void> deleteExpense(String id) async {
    await _db.collection(_collectionName).doc(id).delete();
  }

  Future<Expense?> getExpense(String id) async {
    final data = await _db.collection(_collectionName).doc(id).get();
    if (data == null) return null;
    return Expense.fromJson(data);
  }

  Future<List<Expense>> getAllExpenses() async {
    final data = await _db.collection(_collectionName).get();
    if (data == null) return [];

    return data.entries.map((entry) {
      final expenseData = entry.value as Map<String, dynamic>;
      return Expense.fromJson(expenseData);
    }).toList();
  }

  Future<void> deleteAllExpenses() async {
    final expenses = await getAllExpenses();
    for (final expense in expenses) {
      await deleteExpense(expense.id);
    }
  }

  Stream<Map<String, dynamic>?> watchExpenses() {
    return _db.collection(_collectionName).stream;
  }
}
