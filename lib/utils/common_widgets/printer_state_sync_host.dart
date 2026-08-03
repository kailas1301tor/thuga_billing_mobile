// lib/utils/common_widgets/printer_state_sync_host.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thuga/src/printer/notifier/printer_notifier.dart';
import 'package:thuga/src/printer/state/printer_state.dart';

/// Syncs printer Bluetooth status when mounted and on app resume.
class PrinterStateSyncHost extends ConsumerStatefulWidget {
  const PrinterStateSyncHost({super.key, required this.child});

  final Widget child;

  @override
  ConsumerState<PrinterStateSyncHost> createState() =>
      _PrinterStateSyncHostState();
}

class _PrinterStateSyncHostState extends ConsumerState<PrinterStateSyncHost>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    Future.microtask(_syncPrinterState);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      Future.microtask(_syncPrinterState);
    }
  }

  void _syncPrinterState() {
    if (!mounted) {
      return;
    }
    ref.read(printerProvider.notifier).syncPrinterState();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}

/// True when a printer is saved or currently connected — print can be attempted.
bool selectCanAttemptPrint(PrinterState state) =>
    state.isConnected || state.connectedPrinter != null;
