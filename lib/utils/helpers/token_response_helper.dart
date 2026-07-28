// lib/utils/helpers/token_response_helper.dart
import 'package:thuga/utils/helpers/safe_converters.dart';

class ParsedAuthTokens {
  const ParsedAuthTokens({
    required this.accessToken,
    required this.refreshToken,
  });

  final String accessToken;
  final String refreshToken;
}

/// Extracts access/refresh tokens from API payloads that may be flat or nested
/// under `results.data` (same shape as login).
ParsedAuthTokens parseAuthTokensFromResponse(dynamic data) {
  final map = convertToMap(data);

  var access = convertToString(map['access']);
  var refresh = convertToString(map['refresh']);

  if (access.isEmpty || refresh.isEmpty) {
    final nested = convertToMap(map['results']);
    final inner = convertToMap(nested['data']);
    if (access.isEmpty) {
      access = convertToString(inner['access']);
    }
    if (refresh.isEmpty) {
      refresh = convertToString(inner['refresh']);
    }
  }

  return ParsedAuthTokens(accessToken: access, refreshToken: refresh);
}

String parseAccessTokenFromResponse(dynamic data) =>
    parseAuthTokensFromResponse(data).accessToken;
