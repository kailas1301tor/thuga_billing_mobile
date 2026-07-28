// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customers_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CustomersNotifier)
final customersProvider = CustomersNotifierProvider._();

final class CustomersNotifierProvider
    extends $NotifierProvider<CustomersNotifier, CustomersState> {
  CustomersNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'customersProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$customersNotifierHash();

  @$internal
  @override
  CustomersNotifier create() => CustomersNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CustomersState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CustomersState>(value),
    );
  }
}

String _$customersNotifierHash() => r'f169c021f257d72be2375aa9900c97b99c6bed4f';

abstract class _$CustomersNotifier extends $Notifier<CustomersState> {
  CustomersState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<CustomersState, CustomersState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<CustomersState, CustomersState>,
              CustomersState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
