import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_project/providers/expense_provider.dart';
import 'package:flutter_project/models/category.dart';
import 'package:flutter_project/widgets/common/loading_widget.dart';
import 'package:flutter_project/widgets/statistics/pie_chart_widget.dart';
import 'package:flutter_project/widgets/statistics/summary_card.dart';
import 'package:flutter_project/utils/constants.dart';
import 'package:flutter_project/utils/currency_formatter.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thống kê'),
      ),
      body: Consumer<ExpenseProvider>(
        builder: (context, expenseProvider, child) {
          if (expenseProvider.isLoading) {
            return const LoadingWidget();
          }

          final totalAmount = expenseProvider.totalAmount;
          final totalByCategory = expenseProvider.totalByCategory;
          final expenseCount = expenseProvider.expenses.length;

          return ListView(
            padding: const EdgeInsets.all(AppConstants.paddingMedium),
            children: [
              Row(
                children: [
                  Expanded(
                    child: SummaryCard(
                      title: 'Tổng chi',
                      value: CurrencyFormatter.formatCompact(totalAmount),
                      icon: Icons.account_balance_wallet,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(width: AppConstants.paddingMedium),
                  Expanded(
                    child: SummaryCard(
                      title: 'Giao dịch',
                      value: '$expenseCount',
                      icon: Icons.receipt,
                      color: AppColors.secondary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppConstants.paddingLarge),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(AppConstants.paddingMedium),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Chi tiêu theo danh mục',
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                      const SizedBox(height: AppConstants.paddingMedium),
                      if (totalByCategory.isNotEmpty)
                        PieChartWidget(data: totalByCategory)
                      else
                        const Center(
                          child: Padding(
                            padding: EdgeInsets.all(AppConstants.paddingLarge),
                            child: Text('Không có dữ liệu'),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppConstants.paddingMedium),
              Card(
                child: Column(
                  children: totalByCategory.entries.map((entry) {
                    final category =
                        DefaultCategories.getCategoryById(entry.key);
                    final percentage =
                        (entry.value / totalAmount * 100).toStringAsFixed(1);

                    return ListTile(
                      leading: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          // ignore: deprecated_member_use
                          color: category?.color.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          category?.icon ?? Icons.category,
                          color: category?.color,
                          size: 20,
                        ),
                      ),
                      title: Text(category?.name ?? 'Không xác định'),
                      subtitle: Text('$percentage%'),
                      trailing: Text(
                        CurrencyFormatter.format(entry.value),
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
