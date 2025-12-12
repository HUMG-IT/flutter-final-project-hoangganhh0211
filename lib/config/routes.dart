import 'package:flutter/material.dart';

class AppRoutes {
  static const String splash = '/';
  static const String home = '/home';
  static const String login = '/login';
  static const String register = '/register';
  static const String addExpense = '/add-expense';
  static const String editExpense = '/edit-expense';
  static const String expenseDetail = '/expense-detail';
  static const String statistics = '/statistics';
  static const String profile = '/profile';
  static const String editProfile = '/edit-profile';
  static const String categories = '/categories';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      splash: (context) => const Placeholder(),
      home: (context) => const Placeholder(),
      login: (context) => const Placeholder(),
      register: (context) => const Placeholder(),
      addExpense: (context) => const Placeholder(),
      editExpense: (context) => const Placeholder(),
      expenseDetail: (context) => const Placeholder(),
      statistics: (context) => const Placeholder(),
      profile: (context) => const Placeholder(),
      categories: (context) => const Placeholder(),
    };
  }
}
