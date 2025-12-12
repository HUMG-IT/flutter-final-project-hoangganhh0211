import 'package:flutter/material.dart';
import 'package:flutter_project/models/category.dart';
import 'package:flutter_project/utils/constants.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Danh mục'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(AppConstants.paddingSmall),
        itemCount: DefaultCategories.categories.length,
        itemBuilder: (context, index) {
          final category = DefaultCategories.categories[index];
          return Card(
            margin: const EdgeInsets.symmetric(
              horizontal: AppConstants.paddingMedium,
              vertical: AppConstants.paddingSmall,
            ),
            child: ListTile(
              leading: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  // ignore: deprecated_member_use
                  color: category.color.withOpacity(0.2),
                  borderRadius:
                      BorderRadius.circular(AppConstants.borderRadiusSmall),
                ),
                child: Icon(
                  category.icon,
                  color: category.color,
                  size: AppConstants.iconSizeMedium,
                ),
              ),
              title: Text(
                category.name,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              subtitle: Text('ID: ${category.id}'),
            ),
          );
        },
      ),
    );
  }
}
