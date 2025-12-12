import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_project/models/expense.dart';

class SupabaseExpenseService {
  final SupabaseClient _supabase = Supabase.instance.client;

  String get _userId {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) throw Exception('User not logged in');
    return userId;
  }

  Future<void> addExpense(Expense expense) async {
    await _supabase.from('expenses').insert({
      ...expense.toJson(),
      'user_id': _userId,
    });
  }

  Future<void> updateExpense(Expense expense) async {
    await _supabase
        .from('expenses')
        .update(expense.toJson())
        .eq('id', expense.id)
        .eq('user_id', _userId);
  }

  Future<void> deleteExpense(String id) async {
    await _supabase
        .from('expenses')
        .delete()
        .eq('id', id)
        .eq('user_id', _userId);
  }

  Stream<List<Expense>> getExpensesStream() {
    return _supabase
        .from('expenses')
        .stream(primaryKey: ['id'])
        .eq('user_id', _userId)
        .order('date', ascending: false)
        .map((data) {
          return data.map((json) => Expense.fromJson(json)).toList();
        });
  }

  Future<List<Expense>> getAllExpenses() async {
    final response = await _supabase
        .from('expenses')
        .select()
        .eq('user_id', _userId)
        .order('date', ascending: false);

    return (response as List).map((json) => Expense.fromJson(json)).toList();
  }

  Future<Expense?> getExpenseById(String id) async {
    final response = await _supabase
        .from('expenses')
        .select()
        .eq('id', id)
        .eq('user_id', _userId)
        .maybeSingle();

    if (response == null) return null;
    return Expense.fromJson(response);
  }
}
