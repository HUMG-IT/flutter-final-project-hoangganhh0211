import 'package:flutter/material.dart';
import 'package:flutter_project/utils/enums.dart';
import 'package:flutter_project/utils/date_formatter.dart';

class FilterProvider extends ChangeNotifier {
  FilterType _filterType = FilterType.all;
  String? _selectedCategoryId;
  DateTime? _startDate;
  DateTime? _endDate;
  SortType _sortType = SortType.dateDescending;

  FilterType get filterType => _filterType;
  String? get selectedCategoryId => _selectedCategoryId;
  DateTime? get startDate => _startDate;
  DateTime? get endDate => _endDate;
  SortType get sortType => _sortType;

  bool get hasActiveFilters =>
      _filterType != FilterType.all || _selectedCategoryId != null;

  void setFilterType(FilterType type) {
    _filterType = type;
    _updateDateRangeForFilterType();
    notifyListeners();
  }

  void setCategory(String? categoryId) {
    _selectedCategoryId = categoryId;
    notifyListeners();
  }

  void setDateRange(DateTime? start, DateTime? end) {
    _startDate = start;
    _endDate = end;
    if (start != null && end != null) {
      _filterType = FilterType.custom;
    }
    notifyListeners();
  }

  void setSortType(SortType type) {
    _sortType = type;
    notifyListeners();
  }

  void clearFilters() {
    _filterType = FilterType.all;
    _selectedCategoryId = null;
    _startDate = null;
    _endDate = null;
    notifyListeners();
  }

  void _updateDateRangeForFilterType() {
    final now = DateTime.now();

    switch (_filterType) {
      case FilterType.today:
        _startDate = DateFormatter.getStartOfDay(now);
        _endDate = DateFormatter.getEndOfDay(now);
        break;
      case FilterType.week:
        final weekStart = now.subtract(Duration(days: now.weekday - 1));
        _startDate = DateFormatter.getStartOfDay(weekStart);
        _endDate =
            DateFormatter.getEndOfDay(weekStart.add(const Duration(days: 6)));
        break;
      case FilterType.month:
        _startDate = DateFormatter.getStartOfMonth(now);
        _endDate = DateFormatter.getEndOfMonth(now);
        break;
      case FilterType.year:
        _startDate = DateFormatter.getStartOfYear(now);
        _endDate = DateFormatter.getEndOfYear(now);
        break;
      case FilterType.all:
        _startDate = null;
        _endDate = null;
        break;
      case FilterType.custom:
        break;
    }
  }

  String getSortByKey() {
    switch (_sortType) {
      case SortType.dateDescending:
        return 'dateDesc';
      case SortType.dateAscending:
        return 'dateAsc';
      case SortType.amountDescending:
        return 'amountDesc';
      case SortType.amountAscending:
        return 'amountAsc';
      case SortType.titleAscending:
        return 'titleAsc';
      case SortType.titleDescending:
        return 'titleDesc';
    }
  }
}
