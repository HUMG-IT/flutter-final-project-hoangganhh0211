import 'dart:io';
import 'package:flutter_project/models/expense.dart';
import 'package:flutter_project/models/category.dart';
import 'package:flutter_project/utils/date_formatter.dart';
import 'package:flutter_project/utils/currency_formatter.dart';
import 'package:path_provider/path_provider.dart';

class ExportService {
  static Future<String> exportToCSV(List<Expense> expenses) async {
    final buffer = StringBuffer();
    buffer.writeln('Ngày,Tiêu đề,Danh mục,Số tiền,Ghi chú');

    for (final expense in expenses) {
      final category = DefaultCategories.getCategoryById(expense.categoryId);
      final categoryName = category?.name ?? 'Không xác định';

      buffer.writeln(
        '${DateFormatter.formatDate(expense.date)},'
        '"${expense.title}",'
        '"$categoryName",'
        '${expense.amount},'
        '"${expense.description ?? ""}"',
      );
    }

    return buffer.toString();
  }

  static Future<File> saveCSVToFile(String csvContent, String fileName) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/$fileName');
    await file.writeAsString(csvContent);
    return file;
  }

  static Future<String> exportToText(List<Expense> expenses) async {
    final buffer = StringBuffer();
    buffer.writeln('BÁO CÁO CHI TIÊU');
    buffer.writeln('=' * 50);
    buffer
        .writeln('Ngày xuất: ${DateFormatter.formatDateTime(DateTime.now())}');
    buffer.writeln('Tổng số giao dịch: ${expenses.length}');
    buffer.writeln('');

    double total = 0;
    for (final expense in expenses) {
      total += expense.amount;
      final category = DefaultCategories.getCategoryById(expense.categoryId);
      final categoryName = category?.name ?? 'Không xác định';

      buffer.writeln('${DateFormatter.formatDate(expense.date)}');
      buffer.writeln('Tiêu đề: ${expense.title}');
      buffer.writeln('Danh mục: $categoryName');
      buffer.writeln('Số tiền: ${CurrencyFormatter.format(expense.amount)}');
      if (expense.description != null && expense.description!.isNotEmpty) {
        buffer.writeln('Ghi chú: ${expense.description}');
      }
      buffer.writeln('-' * 50);
    }

    buffer.writeln('');
    buffer.writeln('TỔNG CỘNG: ${CurrencyFormatter.format(total)}');
    buffer.writeln('=' * 50);

    return buffer.toString();
  }

  static Future<File> exportExpensesToCSV(
    List<Expense> expenses,
    String fileName,
  ) async {
    final csvContent = await exportToCSV(expenses);
    return await saveCSVToFile(csvContent, fileName);
  }

  static Future<File> exportExpensesToText(
    List<Expense> expenses,
    String fileName,
  ) async {
    final textContent = await exportToText(expenses);
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/$fileName');
    await file.writeAsString(textContent);
    return file;
  }
}
