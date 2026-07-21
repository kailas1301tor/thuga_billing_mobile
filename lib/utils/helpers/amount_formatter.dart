// lib/utils/helpers/amount_formatter.dart
import 'package:intl/intl.dart';

/// Formats a numeric amount for UI display with Indian grouping and no
/// unnecessary trailing zeros (e.g. 102.00 → ₹102, 105.20 → ₹105.2).
String formatDisplayCurrency(
  num value, {
  String symbol = '₹',
  int maxDecimalDigits = 2,
}) {
  final fraction = maxDecimalDigits > 0 ? '.${'#' * maxDecimalDigits}' : '';
  return '$symbol${NumberFormat('#,##0$fraction', 'en_IN').format(value)}';
}

/// Formats a percentage for UI display without unnecessary trailing zeros
/// (e.g. 5.00 → 5%, 5.20 → 5.2%).
String formatDisplayPercent(
  num value, {
  int maxDecimalDigits = 2,
}) {
  final fraction = maxDecimalDigits > 0 ? '.${'#' * maxDecimalDigits}' : '';
  return '${NumberFormat('#,##0$fraction').format(value)}%';
}
