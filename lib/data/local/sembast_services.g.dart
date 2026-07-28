// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sembast_services.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(sembastServices)
final sembastServicesProvider = SembastServicesProvider._();

final class SembastServicesProvider
    extends
        $FunctionalProvider<SembastServices, SembastServices, SembastServices>
    with $Provider<SembastServices> {
  SembastServicesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sembastServicesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sembastServicesHash();

  @$internal
  @override
  $ProviderElement<SembastServices> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SembastServices create(Ref ref) {
    return sembastServices(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SembastServices value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SembastServices>(value),
    );
  }
}

String _$sembastServicesHash() => r'3466e5f4de0d0c6528ca5ec95e7d818b85b3eef3';
