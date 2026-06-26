import 'package:intl/intl.dart';

/// Standard project date formatter
String formatDate(DateTime date, {String pattern = 'dd MMM yyyy, hh:mm a'}) {
  return DateFormat(pattern).format(date);
}
