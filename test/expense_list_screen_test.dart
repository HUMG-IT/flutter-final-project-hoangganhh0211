import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:flutter_project/providers/expense_provider.dart';
import 'package:flutter_project/screens/expense/expense_list_screen.dart';

void main() {
  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await Supabase.initialize(
      url: 'https://fake.supabase.co',
      anonKey: 'fake-anon-key',
    );
  });
  testWidgets('ExpenseListScreen shows empty state',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider(
          create: (_) => ExpenseProvider(),
          child: const ExpenseListScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Chưa có giao dịch nào'), findsOneWidget);
  });
}
