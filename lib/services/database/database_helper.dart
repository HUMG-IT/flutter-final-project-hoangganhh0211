import 'package:flutter_project/models/expense.dart';
import 'package:flutter_project/utils/date_formatter.dart';

class DatabaseHelper {
  static List<Expense> sortExpenses(
    List<Expense> expenses,
    String sortBy,
  ) {
    final sortedList = List<Expense>.from(expenses);

    switch (sortBy) {
      case 'dateDesc':
        sortedList.sort((a, b) => b.date.compareTo(a.date));
        break;
      case 'dateAsc':
        sortedList.sort((a, b) => a.date.compareTo(b.date));
        break;
      case 'amountDesc':
        sortedList.sort((a, b) => b.amount.compareTo(a.amount));
        break;
      case 'amountAsc':
        sortedList.sort((a, b) => a.amount.compareTo(b.amount));
        break;
      case 'titleAsc':
        sortedList.sort((a, b) => a.title.compareTo(b.title));
        break;
      case 'titleDesc':
        sortedList.sort((a, b) => b.title.compareTo(a.title));
        break;
      default:
        sortedList.sort((a, b) => b.date.compareTo(a.date));
    }

    return sortedList;
  }

  static List<Expense> filterByCategory(
    List<Expense> expenses,
    String? categoryId,
  ) {
    if (categoryId == null || categoryId.isEmpty) {
      return expenses;
    }
    return expenses.where((e) => e.categoryId == categoryId).toList();
  }

  static List<Expense> filterByDateRange(
    List<Expense> expenses,
    DateTime? startDate,
    DateTime? endDate,
  ) {
    if (startDate == null && endDate == null) {
      return expenses;
    }

    return expenses.where((expense) {
      if (startDate != null && expense.date.isBefore(startDate)) {
        return false;
      }
      if (endDate != null && expense.date.isAfter(endDate)) {
        return false;
      }
      return true;
    }).toList();
  }

  static List<Expense> searchExpenses(
    List<Expense> expenses,
    String query,
  ) {
    if (query.isEmpty) {
      return expenses;
    }

    final lowerQuery = query.toLowerCase();
    return expenses.where((expense) {
      return expense.title.toLowerCase().contains(lowerQuery) ||
          (expense.description?.toLowerCase().contains(lowerQuery) ?? false);
    }).toList();
  }

  static double calculateTotal(List<Expense> expenses) {
    return expenses.fold(0.0, (sum, expense) => sum + expense.amount);
  }

  static Map<String, double> calculateTotalByCategory(
    List<Expense> expenses,
  ) {
    final Map<String, double> totals = {};

    for (final expense in expenses) {
      totals[expense.categoryId] =
          (totals[expense.categoryId] ?? 0) + expense.amount;
    }

    return totals;
  }

  static Map<String, List<Expense>> groupByDate(List<Expense> expenses) {
    final Map<String, List<Expense>> grouped = {};

    for (final expense in expenses) {
      final dateKey = DateFormatter.formatDate(expense.date);
      grouped[dateKey] = [...(grouped[dateKey] ?? []), expense];
    }

    return grouped;
  }

  static Map<String, List<Expense>> groupByMonth(List<Expense> expenses) {
    final Map<String, List<Expense>> grouped = {};

    for (final expense in expenses) {
      final monthKey = DateFormatter.formatMonth(expense.date);
      grouped[monthKey] = [...(grouped[monthKey] ?? []), expense];
    }

    return grouped;
  }

  static Map<String, List<Expense>> groupByCategory(List<Expense> expenses) {
    final Map<String, List<Expense>> grouped = {};

    for (final expense in expenses) {
      grouped[expense.categoryId] = [
        ...(grouped[expense.categoryId] ?? []),
        expense
      ];
    }

    return grouped;
  }

  static List<Expense> getExpensesForToday(List<Expense> expenses) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = today.add(const Duration(days: 1));

    return expenses.where((expense) {
      return expense.date.isAfter(today) && expense.date.isBefore(tomorrow);
    }).toList();
  }

  static List<Expense> getExpensesForWeek(List<Expense> expenses) {
    final now = DateTime.now();
    final weekStart = now.subtract(Duration(days: now.weekday - 1));
    final weekEnd = weekStart.add(const Duration(days: 7));

    return filterByDateRange(expenses, weekStart, weekEnd);
  }

  static List<Expense> getExpensesForMonth(List<Expense> expenses) {
    final now = DateTime.now();
    final monthStart = DateTime(now.year, now.month, 1);
    final monthEnd = DateTime(now.year, now.month + 1, 0, 23, 59, 59);

    return filterByDateRange(expenses, monthStart, monthEnd);
  }

  static List<Expense> getExpensesForYear(List<Expense> expenses) {
    final now = DateTime.now();
    final yearStart = DateTime(now.year, 1, 1);
    final yearEnd = DateTime(now.year, 12, 31, 23, 59, 59);

    return filterByDateRange(expenses, yearStart, yearEnd);
  }
}
