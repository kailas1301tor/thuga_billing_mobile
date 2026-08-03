// lib/src/printer/service/printer_crashlytics_service.dart
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:thuga/services/firebase_service.dart';
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

  /// Breadcrumb log for printer scan/connect lifecycle (non-fatal).
  Future<void> logAction({
    required String action,
    String? message,
    Map<String, Object?>? context,
  }) async {
    try {
      final details = _formatContext(context);
      final line = details.isEmpty
          ? 'printer:$action${message != null ? ' — $message' : ''}'
          : 'printer:$action${message != null ? ' — $message' : ''} | $details';

      if (kDebugMode) {
        debugPrint('🔵 PRINTER CRASHLYTICS: $line');
        return;
      }

      if (!isFirebaseInitialized) {
        return;
      }

      final crashlytics = FirebaseCrashlytics.instance;
      await crashlytics.log(line);
      await crashlytics.setCustomKey('printer_action', action);
      if (message != null && message.isNotEmpty) {
        await crashlytics.setCustomKey('printer_log_message', message);
      }
      await _applyContext(crashlytics, context);
    } catch (logError) {
      debugPrint('🔴 PRINTER CRASHLYTICS LOG FAILED: $logError');
    }
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

      if (!isFirebaseInitialized) {
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

      await _applyContext(crashlytics, context);

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

  Future<void> _applyContext(
    FirebaseCrashlytics crashlytics,
    Map<String, Object?>? context,
  ) async {
    for (final entry in context?.entries ?? <MapEntry<String, Object?>>[]) {
      final value = entry.value;
      if (value == null) continue;

      final key = switch (entry.key) {
        'name' => 'printer_name',
        'address' => 'printer_address',
        'orderNumber' => 'order_number',
        'count' => 'printer_count',
        'silently' => 'printer_silent_connect',
        'attempt' => 'printer_connect_attempt',
        'maxAttempts' => 'printer_connect_max_attempts',
        'paperSize' => 'printer_paper_size',
        'source' => 'printer_source',
        'byteCount' => 'printer_byte_count',
        'chunkIndex' => 'printer_chunk_index',
        'chunkCount' => 'printer_chunk_count',
        'chunkSize' => 'printer_chunk_size',
        'itemCount' => 'printer_item_count',
        'stage' => 'printer_flow_stage',
        'warmupSuccess' => 'printer_warmup_success',
        'printAttempt' => 'printer_print_attempt',
        'printed' => 'printer_printed',
        _ => 'ctx_${entry.key}',
      };
      final stringValue = key == 'printer_address'
          ? _maskBluetoothAddress(value.toString())
          : value.toString();
      await crashlytics.setCustomKey(key, stringValue);
    }
  }

  String _formatContext(Map<String, Object?>? context) {
    if (context == null || context.isEmpty) {
      return '';
    }

    return context.entries
        .where((entry) => entry.value != null)
        .map((entry) {
          final value = entry.key == 'address'
              ? _maskBluetoothAddress(entry.value.toString())
              : entry.value.toString();
          return '${entry.key}=$value';
        })
        .join(' ');
  }

  String _maskBluetoothAddress(String address) {
    final parts = address.split(':');
    if (parts.length < 6) {
      return address;
    }
    return '${parts[0]}:${parts[1]}:**:**:${parts[4]}:${parts[5]}';
  }
}
