import 'package:intl/intl.dart';

class CurrencyFormatter {
  static String format(double amount) {
    final formatter = NumberFormat('#,###', 'vi_VN');
    return '${formatter.format(amount)}₫';
  }

  static String formatCompact(double amount) {
    if (amount >= 1000000000) {
      return '${(amount / 1000000000).toStringAsFixed(1)}B₫';
    } else if (amount >= 1000000) {
      return '${(amount / 1000000).toStringAsFixed(1)}M₫';
    } else if (amount >= 1000) {
      return '${(amount / 1000).toStringAsFixed(1)}K₫';
    } else {
      return '${amount.toStringAsFixed(0)}₫';
    }
  }

  static String formatWithoutSymbol(double amount) {
    final formatter = NumberFormat('#,###', 'vi_VN');
    return formatter.format(amount);
  }

  static double? parse(String amountString) {
    try {
      final cleanString = amountString
          .replaceAll('₫', '')
          .replaceAll(',', '')
          .replaceAll('.', '')
          .trim();
      return double.tryParse(cleanString);
    } catch (e) {
      return null;
    }
  }

  static String formatInput(String input) {
    final cleanString = input.replaceAll(',', '').replaceAll('.', '');
    final amount = double.tryParse(cleanString);
    if (amount == null) return input;

    final formatter = NumberFormat('#,###', 'vi_VN');
    return formatter.format(amount);
  }
}
