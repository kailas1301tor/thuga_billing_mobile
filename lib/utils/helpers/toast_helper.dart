import 'package:flutter/material.dart';
import 'package:thuga/utils/common_widgets/custom_toast.dart' as ct;

/// Show a standard toast message.
void showCustomToast({required String message}) {
  debugPrint('✅ SUCCESS: $message');
  ct.showCustomToast(message: message, isSuccess: true);
}

/// Show a standard error toast message.
void showCustomErrorToast({required String message}) {
  debugPrint('❌ ERROR: $message');
  ct.showCustomToast(message: message, isSuccess: false);
}
