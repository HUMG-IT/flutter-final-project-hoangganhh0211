import 'package:flutter/material.dart';
import 'package:flutter_project/models/category.dart';
import 'package:flutter_project/utils/constants.dart';

class CategorySelector extends StatelessWidget {
  final String? selectedCategoryId;
  final ValueChanged<String?> onCategorySelected;

  const CategorySelector({
    super.key,
    required this.selectedCategoryId,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Danh mục',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: AppConstants.paddingMedium),
        Wrap(
          spacing: AppConstants.paddingSmall,
          runSpacing: AppConstants.paddingSmall,
          children: DefaultCategories.categories.map((category) {
            final isSelected = selectedCategoryId == category.id;
            return ChoiceChip(
              label: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    category.icon,
                    size: AppConstants.iconSizeSmall,
                    color: isSelected ? Colors.white : category.color,
                  ),
                  const SizedBox(width: 4),
                  Text(category.name),
                ],
              ),
              selected: isSelected,
              onSelected: (selected) {
                onCategorySelected(selected ? category.id : null);
              },
              selectedColor: category.color,
              // ignore: deprecated_member_use
              backgroundColor: category.color.withOpacity(0.1),
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : AppColors.textPrimary,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
