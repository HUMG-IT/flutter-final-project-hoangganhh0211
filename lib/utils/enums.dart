enum FilterType {
  all,
  today,
  week,
  month,
  year,
  custom,
}

enum SortType {
  dateDescending,
  dateAscending,
  amountDescending,
  amountAscending,
  titleAscending,
  titleDescending,
}

enum StatisticsPeriod {
  week,
  month,
  year,
  all,
}

enum ChartType {
  pie,
  bar,
  line,
}

extension FilterTypeExtension on FilterType {
  String get label {
    switch (this) {
      case FilterType.all:
        return 'Tất cả';
      case FilterType.today:
        return 'Hôm nay';
      case FilterType.week:
        return 'Tuần này';
      case FilterType.month:
        return 'Tháng này';
      case FilterType.year:
        return 'Năm này';
      case FilterType.custom:
        return 'Tùy chọn';
    }
  }
}

extension SortTypeExtension on SortType {
  String get label {
    switch (this) {
      case SortType.dateDescending:
        return 'Ngày mới nhất';
      case SortType.dateAscending:
        return 'Ngày cũ nhất';
      case SortType.amountDescending:
        return 'Số tiền giảm dần';
      case SortType.amountAscending:
        return 'Số tiền tăng dần';
      case SortType.titleAscending:
        return 'Tên A-Z';
      case SortType.titleDescending:
        return 'Tên Z-A';
    }
  }
}

extension StatisticsPeriodExtension on StatisticsPeriod {
  String get label {
    switch (this) {
      case StatisticsPeriod.week:
        return 'Tuần';
      case StatisticsPeriod.month:
        return 'Tháng';
      case StatisticsPeriod.year:
        return 'Năm';
      case StatisticsPeriod.all:
        return 'Tất cả';
    }
  }
}
