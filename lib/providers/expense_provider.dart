import 'package:flutter/material.dart';
import 'package:flutter_project/models/expense.dart';
import 'package:flutter_project/services/database/localstore_service.dart';
import 'package:flutter_project/services/database/database_helper.dart';

class ExpenseProvider extends ChangeNotifier {
  final LocalstoreService _localstoreService = LocalstoreService();

  List<Expense> _expenses = [];
  bool _isLoading = false;
  String? _error;

  String? _selectedCategoryId;
  DateTime? _startDate;
  DateTime? _endDate;
  String _searchQuery = '';
  String _sortBy = 'dateDesc';

  List<Expense> get expenses {
    var filtered = List<Expense>.from(_expenses);

    if (_selectedCategoryId != null) {
      filtered = DatabaseHelper.filterByCategory(filtered, _selectedCategoryId);
    }

    if (_startDate != null || _endDate != null) {
      filtered =
          DatabaseHelper.filterByDateRange(filtered, _startDate, _endDate);
    }

    if (_searchQuery.isNotEmpty) {
      filtered = DatabaseHelper.searchExpenses(filtered, _searchQuery);
    }

    return DatabaseHelper.sortExpenses(filtered, _sortBy);
  }

  bool get isLoading => _isLoading;
  String? get error => _error;
  String? get selectedCategoryId => _selectedCategoryId;
  DateTime? get startDate => _startDate;
  DateTime? get endDate => _endDate;
  String get searchQuery => _searchQuery;
  String get sortBy => _sortBy;

  double get totalAmount => DatabaseHelper.calculateTotal(expenses);

  Map<String, double> get totalByCategory =>
      DatabaseHelper.calculateTotalByCategory(expenses);

  Future<void> loadExpenses() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _expenses = await _localstoreService.getAllExpenses();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addExpense(Expense expense) async {
    try {
      await _localstoreService.saveExpense(expense);
      _expenses.add(expense);
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      rethrow;
    }
  }

  Future<void> updateExpense(Expense expense) async {
    try {
      await _localstoreService.updateExpense(expense);
      final index = _expenses.indexWhere((e) => e.id == expense.id);
      if (index != -1) {
        _expenses[index] = expense;
        notifyListeners();
      }
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      rethrow;
    }
  }

  Future<void> deleteExpense(String id) async {
    try {
      await _localstoreService.deleteExpense(id);
      _expenses.removeWhere((e) => e.id == id);
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      rethrow;
    }
  }

  Future<void> deleteAllExpenses() async {
    try {
      await _localstoreService.deleteAllExpenses();
      _expenses.clear();
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      rethrow;
    }
  }

  void setCategory(String? categoryId) {
    _selectedCategoryId = categoryId;
    notifyListeners();
  }

  void setDateRange(DateTime? start, DateTime? end) {
    _startDate = start;
    _endDate = end;
    notifyListeners();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void setSortBy(String sortBy) {
    _sortBy = sortBy;
    notifyListeners();
  }

  void clearFilters() {
    _selectedCategoryId = null;
    _startDate = null;
    _endDate = null;
    _searchQuery = '';
    notifyListeners();
  }

  List<Expense> getExpensesForToday() {
    return DatabaseHelper.getExpensesForToday(_expenses);
  }

  List<Expense> getExpensesForWeek() {
    return DatabaseHelper.getExpensesForWeek(_expenses);
  }

  List<Expense> getExpensesForMonth() {
    return DatabaseHelper.getExpensesForMonth(_expenses);
  }

  List<Expense> getExpensesForYear() {
    return DatabaseHelper.getExpensesForYear(_expenses);
  }
}
