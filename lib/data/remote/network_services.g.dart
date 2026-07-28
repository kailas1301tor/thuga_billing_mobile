// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'network_services.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(networkServices)
final networkServicesProvider = NetworkServicesProvider._();

final class NetworkServicesProvider
    extends
        $FunctionalProvider<NetworkServices, NetworkServices, NetworkServices>
    with $Provider<NetworkServices> {
  NetworkServicesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'networkServicesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$networkServicesHash();

  @$internal
  @override
  $ProviderElement<NetworkServices> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  NetworkServices create(Ref ref) {
    return networkServices(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NetworkServices value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NetworkServices>(value),
    );
  }
}

String _$networkServicesHash() => r'517def081a05387694a845bad5289f164ee87c8c';
