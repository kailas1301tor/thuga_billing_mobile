// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'printer_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PrinterNotifier)
final printerProvider = PrinterNotifierProvider._();

final class PrinterNotifierProvider
    extends $NotifierProvider<PrinterNotifier, PrinterState> {
  PrinterNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'printerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$printerNotifierHash();

  @$internal
  @override
  PrinterNotifier create() => PrinterNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PrinterState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PrinterState>(value),
    );
  }
}

String _$printerNotifierHash() => r'498044388fc3434e36dcd85280b4a355c7dc4794';

abstract class _$PrinterNotifier extends $Notifier<PrinterState> {
  PrinterState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<PrinterState, PrinterState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<PrinterState, PrinterState>,
              PrinterState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
