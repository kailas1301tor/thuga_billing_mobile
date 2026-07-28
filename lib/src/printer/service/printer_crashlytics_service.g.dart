// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'printer_crashlytics_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(printerCrashlyticsService)
final printerCrashlyticsServiceProvider = PrinterCrashlyticsServiceProvider._();

final class PrinterCrashlyticsServiceProvider
    extends
        $FunctionalProvider<
          PrinterCrashlyticsService,
          PrinterCrashlyticsService,
          PrinterCrashlyticsService
        >
    with $Provider<PrinterCrashlyticsService> {
  PrinterCrashlyticsServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'printerCrashlyticsServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$printerCrashlyticsServiceHash();

  @$internal
  @override
  $ProviderElement<PrinterCrashlyticsService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PrinterCrashlyticsService create(Ref ref) {
    return printerCrashlyticsService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PrinterCrashlyticsService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PrinterCrashlyticsService>(value),
    );
  }
}

String _$printerCrashlyticsServiceHash() =>
    r'ac9650fa98294d7f6f5d507d9831ce00dce19a7d';
