// lib/utils/helpers/date_range_labels.dart
import 'package:thuga/res/constants/string_constants.dart';

/// Stable English IDs used by API / state. Display labels are localized.
abstract final class DateRangeIds {
  static const today = 'Today';
  static const yesterday = 'Yesterday';
  static const last7Days = 'Last 7 Days';
  static const thisMonth = 'This Month';
  static const thisWeek = 'This Week';
  static const allTime = 'All Time';
}

String localizedDateRangeLabel(String id) {
  return switch (id) {
    DateRangeIds.today => Strings.rangeToday,
    DateRangeIds.yesterday => Strings.rangeYesterday,
    DateRangeIds.last7Days => Strings.rangeLast7Days,
    DateRangeIds.thisMonth => Strings.rangeThisMonth,
    DateRangeIds.thisWeek => Strings.rangeThisWeek,
    DateRangeIds.allTime => Strings.rangeAllTime,
    _ => id,
  };
}

(DateTime start, DateTime end) calculateDateRangeForPreset(String preset) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);

  return switch (preset) {
    DateRangeIds.today => (today, today),
    DateRangeIds.yesterday => (
      today.subtract(const Duration(days: 1)),
      today.subtract(const Duration(days: 1)),
    ),
    DateRangeIds.thisWeek => (
      today.subtract(Duration(days: today.weekday - 1)),
      today,
    ),
    DateRangeIds.thisMonth => (
      DateTime(now.year, now.month, 1),
      today,
    ),
    DateRangeIds.last7Days => (
      today.subtract(const Duration(days: 7)),
      today,
    ),
    DateRangeIds.allTime => (
      DateTime(2020, 1, 1),
      today,
    ),
    _ => (today, today),
  };
}
