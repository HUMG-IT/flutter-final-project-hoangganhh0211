import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_project/config/supabase_config.dart';
import 'package:flutter_project/providers/expense_provider.dart';
import 'package:flutter_project/providers/category_provider.dart';
import 'package:flutter_project/providers/filter_provider.dart';
import 'package:flutter_project/providers/auth_provider.dart';
import 'package:flutter_project/config/theme.dart';
import 'package:flutter_project/config/routes.dart';
import 'package:flutter_project/screens/home/home_screen.dart';
import 'package:flutter_project/screens/auth/login_screen.dart';
import 'package:flutter_project/screens/auth/register_screen.dart';
import 'package:flutter_project/screens/expense/add_edit_expense_screen.dart';
import 'package:flutter_project/screens/expense/expense_detail_screen.dart';
import 'package:flutter_project/screens/statistics/statistics_screen.dart';
import 'package:flutter_project/screens/profile/profile_screen.dart';
import 'package:flutter_project/screens/profile/edit_profile_screen.dart';
import 'package:flutter_project/screens/category/category_screen.dart';
import 'package:flutter_project/models/expense.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: SupabaseConfig.supabaseUrl,
    anonKey: SupabaseConfig.supabaseAnonKey,
  );

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ExpenseProvider()),
        ChangeNotifierProvider(create: (_) => CategoryProvider()),
        ChangeNotifierProvider(create: (_) => FilterProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: MaterialApp(
        title: 'Quản lý Chi tiêu',
        theme: AppTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.login,
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case AppRoutes.home:
              return MaterialPageRoute(builder: (_) => const HomeScreen());
            case AppRoutes.login:
              return MaterialPageRoute(builder: (_) => const LoginScreen());
            case AppRoutes.register:
              return MaterialPageRoute(builder: (_) => const RegisterScreen());
            case AppRoutes.addExpense:
              return MaterialPageRoute(
                builder: (_) => const AddEditExpenseScreen(),
              );
            case AppRoutes.editExpense:
              final expense = settings.arguments as Expense?;
              return MaterialPageRoute(
                builder: (_) => AddEditExpenseScreen(expense: expense),
              );
            case AppRoutes.expenseDetail:
              final expense = settings.arguments as Expense;
              return MaterialPageRoute(
                builder: (_) => ExpenseDetailScreen(expense: expense),
              );
            case AppRoutes.statistics:
              return MaterialPageRoute(
                  builder: (_) => const StatisticsScreen());
            case AppRoutes.profile:
              return MaterialPageRoute(builder: (_) => const ProfileScreen());
            case AppRoutes.editProfile:
              return MaterialPageRoute(
                  builder: (_) => const EditProfileScreen());
            case AppRoutes.categories:
              return MaterialPageRoute(builder: (_) => const CategoryScreen());
            default:
              return MaterialPageRoute(builder: (_) => const HomeScreen());
          }
        },
      ),
    );
  }
}
