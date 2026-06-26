import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vyapapp/data/local/sembast_services.dart';
import 'package:vyapapp/res/constants/app_constants.dart';

/// Service for managing local storage of authentication tokens and session data.
class TokenService {
  final SembastServices _sembast;

  TokenService(this._sembast);

  /// Saves both access and refresh tokens.
  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    AppConstants.accessToken = accessToken;
    await _sembast.saveTokens(
      accessToken: accessToken,
      refreshToken: refreshToken,
    );
  }

  /// Saves the user ID.
  Future<void> saveUserId(String userId) async {
    await _sembast.saveUserId(userId);
  }

  /// Retrieves the stored user ID.
  Future<String?> getUserId() async {
    return await _sembast.getUserId();
  }

  /// Retrieves the stored access token.
  Future<String?> getAccessToken() async {
    return await _sembast.getAccessToken();
  }

  /// Retrieves the stored refresh token.
  Future<String?> getRefreshToken() async {
    return await _sembast.getRefreshToken();
  }

  /// Deletes all stored tokens (use on logout).
  Future<void> clearTokens() async {
    AppConstants.accessToken = "";
    await _sembast.clearLocalDb();
  }
}

/// Provider for the [TokenService] instance.
final tokenServiceProvider = Provider<TokenService>((ref) {
  final sembast = ref.watch(sembastServicesProvider);
  return TokenService(sembast);
});

/// Reactive provider for the access token.
/// Other services (like NetworkServices) can watch this.
final accessTokenProvider = FutureProvider<String?>((ref) async {
  final service = ref.watch(tokenServiceProvider);
  return await service.getAccessToken();
});
