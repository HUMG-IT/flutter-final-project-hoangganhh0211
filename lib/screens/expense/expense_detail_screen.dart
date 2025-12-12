import 'package:flutter/material.dart';
import 'package:flutter_project/models/expense.dart';
import 'package:flutter_project/models/category.dart';
import 'package:flutter_project/utils/constants.dart';
import 'package:flutter_project/utils/currency_formatter.dart';
import 'package:flutter_project/utils/date_formatter.dart';

class ExpenseDetailScreen extends StatelessWidget {
  final Expense expense;

  const ExpenseDetailScreen({super.key, required this.expense});

  @override
  Widget build(BuildContext context) {
    final category = DefaultCategories.getCategoryById(expense.categoryId);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chi tiết'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppConstants.paddingMedium),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(AppConstants.paddingLarge),
              child: Column(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      // ignore: deprecated_member_use
                      color: category?.color.withOpacity(0.2),
                      borderRadius:
                          BorderRadius.circular(AppConstants.borderRadiusLarge),
                    ),
                    child: Icon(
                      category?.icon ?? Icons.category,
                      color: category?.color,
                      size: 40,
                    ),
                  ),
                  const SizedBox(height: AppConstants.paddingMedium),
                  Text(
                    expense.title,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppConstants.paddingSmall),
                  Text(
                    CurrencyFormatter.format(expense.amount),
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppConstants.paddingMedium),
          Card(
            child: Column(
              children: [
                _buildInfoRow(
                  context,
                  'Danh mục',
                  category?.name ?? 'Không xác định',
                  Icons.category,
                ),
                const Divider(),
                _buildInfoRow(
                  context,
                  'Ngày',
                  DateFormatter.formatDate(expense.date),
                  Icons.calendar_today,
                ),
                const Divider(),
                _buildInfoRow(
                  context,
                  'Thời gian tạo',
                  DateFormatter.formatDateTime(expense.createdAt),
                  Icons.access_time,
                ),
                if (expense.description != null &&
                    expense.description!.isNotEmpty) ...[
                  const Divider(),
                  _buildInfoRow(
                    context,
                    'Ghi chú',
                    expense.description!,
                    Icons.note,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(
    BuildContext context,
    String label,
    String value,
    IconData icon,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.paddingMedium,
        vertical: AppConstants.paddingSmall,
      ),
      child: Row(
        children: [
          Icon(icon, size: 20, color: AppColors.textSecondary),
          const SizedBox(width: AppConstants.paddingSmall),
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
          ),
          const Spacer(),
          Flexible(
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
