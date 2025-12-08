import 'package:flutter/material.dart';

class AppConstants {
  static const String appName = 'Quản lý Chi tiêu';
  static const String currencySymbol = '₫';

  static const double paddingSmall = 8.0;
  static const double paddingMedium = 16.0;
  static const double paddingLarge = 24.0;

  static const double borderRadiusSmall = 8.0;
  static const double borderRadiusMedium = 12.0;
  static const double borderRadiusLarge = 16.0;

  static const double iconSizeSmall = 20.0;
  static const double iconSizeMedium = 24.0;
  static const double iconSizeLarge = 32.0;
}

class AppStrings {
  static const String home = 'Trang chủ';
  static const String statistics = 'Thống kê';
  static const String profile = 'Cá nhân';
  static const String addExpense = 'Thêm chi tiêu';
  static const String editExpense = 'Sửa chi tiêu';
  static const String deleteExpense = 'Xóa chi tiêu';
  static const String confirmDelete = 'Bạn có chắc chắn muốn xóa?';
  static const String cancel = 'Hủy';
  static const String delete = 'Xóa';
  static const String save = 'Lưu';
  static const String title = 'Tiêu đề';
  static const String amount = 'Số tiền';
  static const String category = 'Danh mục';
  static const String date = 'Ngày';
  static const String description = 'Ghi chú';
  static const String search = 'Tìm kiếm';
  static const String filter = 'Lọc';
  static const String total = 'Tổng';
  static const String noData = 'Không có dữ liệu';
  static const String error = 'Đã có lỗi xảy ra';
  static const String success = 'Thành công';
  static const String titleRequired = 'Vui lòng nhập tiêu đề';
  static const String amountRequired = 'Vui lòng nhập số tiền';
  static const String amountInvalid = 'Số tiền không hợp lệ';
  static const String categoryRequired = 'Vui lòng chọn danh mục';
}

class AppColors {
  static const Color primary = Color(0xFF6200EE);
  static const Color primaryDark = Color(0xFF3700B3);
  static const Color secondary = Color(0xFF03DAC6);
  static const Color error = Color(0xFFB00020);
  static const Color background = Color(0xFFF5F5F5);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color onSecondary = Color(0xFF000000);
  static const Color onBackground = Color(0xFF000000);
  static const Color onSurface = Color(0xFF000000);
  static const Color onError = Color(0xFFFFFFFF);

  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color divider = Color(0xFFBDBDBD);

  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFF9800);
  static const Color info = Color(0xFF2196F3);
}
