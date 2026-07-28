// lib/services/token_service.dart
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thuga/data/local/sembast_services.dart';
import 'package:thuga/res/constants/app_constants.dart';

/// Service for managing local storage of authentication tokens and session data.
///
/// Web uses [SharedPreferences] — avoids sembast_web IndexedDB notification
/// crashes (`JdbNotificationRevision` interop errors on Flutter web).
/// Native uses Sembast.
class TokenService {
  TokenService(this._sembast);

  final SembastServices _sembast;

  static const String _accessKey = 'auth_access_token';
  static const String _refreshKey = 'auth_refresh_token';
  static const String _userIdKey = 'auth_user_id';

  Future<SharedPreferences> get _prefs => SharedPreferences.getInstance();

  /// Saves both access and refresh tokens.
  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    AppConstants.accessToken = accessToken;

    if (kIsWeb) {
      final prefs = await _prefs;
      await prefs.setString(_accessKey, accessToken);
      await prefs.setString(_refreshKey, refreshToken);
      return;
    }

    await _sembast.initialize();
    await _sembast.saveTokens(
      accessToken: accessToken,
      refreshToken: refreshToken,
    );
  }

  /// Saves the user ID.
  Future<void> saveUserId(String userId) async {
    if (kIsWeb) {
      final prefs = await _prefs;
      await prefs.setString(_userIdKey, userId);
      return;
    }

    await _sembast.initialize();
    await _sembast.saveUserId(userId);
  }

  /// Retrieves the stored user ID.
  Future<String?> getUserId() async {
    if (kIsWeb) {
      final prefs = await _prefs;
      return prefs.getString(_userIdKey);
    }

    await _sembast.initialize();
    return _sembast.getUserId();
  }

  /// Retrieves the stored access token and syncs [AppConstants.accessToken].
  Future<String?> getAccessToken() async {
    if (kIsWeb) {
      final prefs = await _prefs;
      final token = prefs.getString(_accessKey);
      if (token != null && token.isNotEmpty) {
        AppConstants.accessToken = token;
      }
      return token;
    }

    await _sembast.initialize();
    final token = await _sembast.getAccessToken();
    if (token != null && token.isNotEmpty) {
      AppConstants.accessToken = token;
    }
    return token;
  }

  /// Retrieves the stored refresh token.
  Future<String?> getRefreshToken() async {
    if (kIsWeb) {
      final prefs = await _prefs;
      return prefs.getString(_refreshKey);
    }

    await _sembast.initialize();
    return _sembast.getRefreshToken();
  }

  /// Deletes all stored tokens (use on logout).
  Future<void> clearTokens() async {
    AppConstants.accessToken = '';

    if (kIsWeb) {
      final prefs = await _prefs;
      await prefs.remove(_accessKey);
      await prefs.remove(_refreshKey);
      await prefs.remove(_userIdKey);
      return;
    }

    await _sembast.initialize();
    await _sembast.clearLocalDb();
  }

  /// Loads persisted session into memory for API interceptors.
  Future<void> hydrateSession() async {
    await getAccessToken();
  }
}

/// Provider for the [TokenService] instance.
final tokenServiceProvider = Provider<TokenService>((ref) {
  final sembast = ref.watch(sembastServicesProvider);
  return TokenService(sembast);
});

/// Reactive provider for the access token.
final accessTokenProvider = FutureProvider<String?>((ref) async {
  final service = ref.watch(tokenServiceProvider);
  return service.getAccessToken();
});
