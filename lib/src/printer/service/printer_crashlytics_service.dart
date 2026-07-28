// lib/src/printer/service/printer_crashlytics_service.dart
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:thuga/services/token_service.dart';
import 'package:thuga/utils/helpers/device_info_helper.dart';
import 'package:thuga/utils/helpers/printer_error_helper.dart';

part 'printer_crashlytics_service.g.dart';

@Riverpod(keepAlive: true)
PrinterCrashlyticsService printerCrashlyticsService(Ref ref) {
  return PrinterCrashlyticsService(ref);
}

class PrinterCrashlyticsService {
  PrinterCrashlyticsService(this._ref);

  final Ref _ref;

  Future<void> reportError({
    required String action,
    required PrinterError error,
    Map<String, Object?>? context,
  }) async {
    await _report(
      eventType: 'error',
      action: action,
      error: error,
      context: context,
    );
  }

  Future<void> reportUnexpected({
    required String action,
    required Object error,
    Map<String, Object?>? context,
  }) async {
    final printerError = PrinterError.fromObject(error);
    await _report(
      eventType: 'unexpected',
      action: action,
      error: printerError,
      context: context,
    );
  }

  Future<void> _report({
    required String eventType,
    required String action,
    required PrinterError error,
    Map<String, Object?>? context,
  }) async {
    try {
      if (kDebugMode) {
        return;
      }

      final crashlytics = FirebaseCrashlytics.instance;
      final device = await DeviceInfoHelper.getSnapshot();
      final companyId = await _ref.read(tokenServiceProvider).getUserId();

      for (final entry in device.toCrashlyticsKeys().entries) {
        await crashlytics.setCustomKey(entry.key, entry.value);
      }

      await crashlytics.setCustomKey('event_type', eventType);
      await crashlytics.setCustomKey('printer_action', action);
      await crashlytics.setCustomKey('printer_error_code', error.code);
      await crashlytics.setCustomKey('printer_error_message', error.message);

      if (companyId != null && companyId.isNotEmpty) {
        await crashlytics.setCustomKey('company_id', companyId);
      }

      for (final entry in context?.entries ?? <MapEntry<String, Object?>>[]) {
        final value = entry.value;
        if (value == null) continue;

        final key = switch (entry.key) {
          'name' => 'printer_name',
          'address' => 'printer_address',
          'orderNumber' => 'order_number',
          _ => 'ctx_${entry.key}',
        };
        final stringValue = key == 'printer_address'
            ? _maskBluetoothAddress(value.toString())
            : value.toString();
        await crashlytics.setCustomKey(key, stringValue);
      }

      await crashlytics.recordError(
        Exception('PrinterError: ${error.code}'),
        StackTrace.current,
        reason: '${error.code} — $action',
        fatal: false,
      );
    } catch (reportError) {
      debugPrint('🔴 PRINTER CRASHLYTICS REPORT FAILED: $reportError');
    }
  }

  String _maskBluetoothAddress(String address) {
    final parts = address.split(':');
    if (parts.length < 6) {
      return address;
    }
    return '${parts[0]}:${parts[1]}:**:**:${parts[4]}:${parts[5]}';
  }
}
