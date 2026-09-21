// lib/utils/helpers/api_error_message_helper.dart
import 'package:thuga/utils/helpers/safe_converters.dart';

/// Extracts the server-provided error message from an API response body.
///
/// When the response contains a field-level `errors` map (e.g. validation
/// errors), all individual error strings are flattened and returned as a
/// newline-joined message. This gives the user actionable detail instead of
/// a generic "Validation failed." label.
///
/// Example input:
/// ```json
/// {
///   "message": "Validation failed.",
///   "errors": {
///     "name": ["A product with this name already exists."],
///     "price": ["Price must be positive."]
///   }
/// }
/// ```
/// Output: `"A product with this name already exists.\nPrice must be positive."`
///
/// Falls back to [fallback] when the body is missing or has no message.
String extractApiErrorMessage(dynamic data, {required String fallback}) {
  final map = convertToMap(data);

  // ── 1. Try to extract field-level validation errors ──────────────────
  final fieldErrors = _extractFieldErrors(map);
  if (fieldErrors.isNotEmpty) return fieldErrors;

  // ── 2. Fall back to top-level message ────────────────────────────────
  final message = convertToString(map['message']).trim();
  return message.isNotEmpty ? message : fallback;
}

/// Walks the `errors` map and collects every individual error string.
///
/// Supports both:
///   • `{ "field": ["error1", "error2"] }`  (Django-style list per field)
///   • `{ "field": "single error" }`         (single string per field)
String _extractFieldErrors(Map<String, dynamic> map) {
  final errorsRaw = map['errors'];
  if (errorsRaw == null) return '';

  final errorsMap = convertToMap(errorsRaw);
  if (errorsMap.isEmpty) return '';

  final List<String> messages = [];

  for (final entry in errorsMap.entries) {
    final value = entry.value;
    if (value is List) {
      for (final item in value) {
        final msg = convertToString(item).trim();
        if (msg.isNotEmpty) messages.add(msg);
      }
    } else {
      final msg = convertToString(value).trim();
      if (msg.isNotEmpty) messages.add(msg);
    }
  }

  return messages.join('\n');
}
