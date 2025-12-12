import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_project/models/category.dart';

class PieChartWidget extends StatelessWidget {
  final Map<String, double> data;

  const PieChartWidget({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return const Center(child: Text('Không có dữ liệu'));
    }

    final total = data.values.fold<double>(0, (sum, value) => sum + value);

    return AspectRatio(
      aspectRatio: 1.3,
      child: PieChart(
        PieChartData(
          sections: data.entries.map((entry) {
            final category = DefaultCategories.getCategoryById(entry.key);
            final percentage = (entry.value / total * 100).toStringAsFixed(1);

            return PieChartSectionData(
              value: entry.value,
              title: '$percentage%',
              color: category?.color ?? Colors.grey,
              radius: 100,
              titleStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            );
          }).toList(),
          sectionsSpace: 2,
          centerSpaceRadius: 40,
        ),
      ),
    );
  }
}
