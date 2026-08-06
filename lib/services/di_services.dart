import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Dispose/invalidate commonly cached providers on logout.
///
/// Add your notifier providers here as you create new features.
void disposeProviders(WidgetRef ref) {
  // ref.invalidate(authProvider);
  // ref.invalidate(homeProvider);
}
