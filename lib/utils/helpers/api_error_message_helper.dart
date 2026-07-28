// lib/utils/helpers/api_error_message_helper.dart
import 'package:thuga/utils/helpers/safe_converters.dart';

/// Extracts the server-provided error message from an API response body.
/// Falls back to [fallback] when the body is missing or has no message.
String extractApiErrorMessage(dynamic data, {required String fallback}) {
  final map = convertToMap(data);
  final message = convertToString(map['message']).trim();
  return message.isNotEmpty ? message : fallback;
}
