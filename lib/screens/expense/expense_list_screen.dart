import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_project/providers/expense_provider.dart';
import 'package:flutter_project/widgets/common/loading_widget.dart';
import 'package:flutter_project/widgets/common/empty_state_widget.dart';
import 'package:flutter_project/widgets/expense/expense_item.dart';
import 'package:flutter_project/utils/constants.dart';

class ExpenseListScreen extends StatelessWidget {
  const ExpenseListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Danh sách chi tiêu'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {},
          ),
        ],
      ),
      body: Consumer<ExpenseProvider>(
        builder: (context, expenseProvider, child) {
          if (expenseProvider.isLoading) {
            return const LoadingWidget();
          }

          final expenses = expenseProvider.expenses;

          if (expenses.isEmpty) {
            return const EmptyStateWidget(
              message: 'Chưa có giao dịch nào',
              icon: Icons.receipt_long_outlined,
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(AppConstants.paddingSmall),
            itemCount: expenses.length,
            itemBuilder: (context, index) {
              final expense = expenses[index];
              return ExpenseItem(
                expense: expense,
                onTap: () {},
              );
            },
          );
        },
      ),
    );
  }
}
