// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'printer_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(printerService)
final printerServiceProvider = PrinterServiceProvider._();

final class PrinterServiceProvider
    extends $FunctionalProvider<PrinterService, PrinterService, PrinterService>
    with $Provider<PrinterService> {
  PrinterServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'printerServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$printerServiceHash();

  @$internal
  @override
  $ProviderElement<PrinterService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  PrinterService create(Ref ref) {
    return printerService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PrinterService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PrinterService>(value),
    );
  }
}

String _$printerServiceHash() => r'8739e730875cd4dcc14702ba2cddf17b0a42aa08';
