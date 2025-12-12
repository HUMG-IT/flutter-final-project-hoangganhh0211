import 'package:flutter/material.dart';
import 'package:flutter_project/models/expense.dart';
import 'package:flutter_project/models/category.dart';
import 'package:flutter_project/utils/constants.dart';
import 'package:flutter_project/utils/currency_formatter.dart';
import 'package:flutter_project/utils/date_formatter.dart';

class ExpenseItem extends StatelessWidget {
  final Expense expense;
  final VoidCallback? onTap;

  const ExpenseItem({
    super.key,
    required this.expense,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final category = DefaultCategories.getCategoryById(expense.categoryId);

    return ListTile(
      onTap: onTap,
      leading: CircleAvatar(
        // ignore: deprecated_member_use
        backgroundColor: category?.color.withOpacity(0.2),
        child: Icon(
          category?.icon ?? Icons.category,
          color: category?.color,
          size: AppConstants.iconSizeSmall,
        ),
      ),
      title: Text(
        expense.title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        DateFormatter.formatDate(expense.date),
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.textSecondary,
            ),
      ),
      trailing: Text(
        CurrencyFormatter.format(expense.amount),
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
      ),
    );
  }
}
