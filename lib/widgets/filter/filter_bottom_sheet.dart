import 'package:flutter/material.dart';
import 'package:flutter_project/utils/constants.dart';
import 'package:flutter_project/utils/enums.dart';
import 'package:flutter_project/widgets/expense/category_selector.dart';

class FilterBottomSheet extends StatefulWidget {
  final FilterType filterType;
  final String? selectedCategoryId;
  final SortType sortType;
  final Function(FilterType, String?, SortType) onApply;

  const FilterBottomSheet({
    super.key,
    required this.filterType,
    this.selectedCategoryId,
    required this.sortType,
    required this.onApply,
  });

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  late FilterType _filterType;
  String? _selectedCategoryId;
  late SortType _sortType;

  @override
  void initState() {
    super.initState();
    _filterType = widget.filterType;
    _selectedCategoryId = widget.selectedCategoryId;
    _sortType = widget.sortType;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.paddingLarge),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Lọc và sắp xếp',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.paddingLarge),
          Text(
            'Thời gian',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: AppConstants.paddingSmall),
          Wrap(
            spacing: AppConstants.paddingSmall,
            children: FilterType.values.map((type) {
              return ChoiceChip(
                label: Text(type.label),
                selected: _filterType == type,
                onSelected: (selected) {
                  setState(() => _filterType = type);
                },
              );
            }).toList(),
          ),
          const SizedBox(height: AppConstants.paddingLarge),
          CategorySelector(
            selectedCategoryId: _selectedCategoryId,
            onCategorySelected: (categoryId) {
              setState(() => _selectedCategoryId = categoryId);
            },
          ),
          const SizedBox(height: AppConstants.paddingLarge),
          Text(
            'Sắp xếp',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: AppConstants.paddingSmall),
          ...SortType.values.map((type) {
            return RadioListTile<SortType>(
              title: Text(type.label),
              value: type,
              // ignore: deprecated_member_use
              groupValue: _sortType,
              // ignore: deprecated_member_use
              onChanged: (value) {
                if (value != null) {
                  setState(() => _sortType = value);
                }
              },
              contentPadding: EdgeInsets.zero,
            );
          }),
          const SizedBox(height: AppConstants.paddingLarge),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                widget.onApply(_filterType, _selectedCategoryId, _sortType);
                Navigator.pop(context);
              },
              child: const Text('Áp dụng'),
            ),
          ),
        ],
      ),
    );
  }
}
