class AppConfig {
  static const String appName = 'Quản lý Chi tiêu';
  static const String version = '1.0.0';
  static const String buildNumber = '1';

  static const bool enableLogging = true;
  static const bool enableAnalytics = false;

  static const String databaseName = 'expense_tracker.db';
  static const int databaseVersion = 1;

  static const Duration animationDuration = Duration(milliseconds: 300);
  static const Duration snackBarDuration = Duration(seconds: 3);

  static const int maxExpenseHistoryDays = 365;
  static const int defaultPageSize = 20;

  static const String dateFormat = 'dd/MM/yyyy';
  static const String timeFormat = 'HH:mm';
  static const String dateTimeFormat = 'dd/MM/yyyy HH:mm';
}
