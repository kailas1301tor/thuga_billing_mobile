// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_purchase_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CreatePurchaseNotifier)
final createPurchaseProvider = CreatePurchaseNotifierProvider._();

final class CreatePurchaseNotifierProvider
    extends $NotifierProvider<CreatePurchaseNotifier, CreatePurchaseState> {
  CreatePurchaseNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'createPurchaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$createPurchaseNotifierHash();

  @$internal
  @override
  CreatePurchaseNotifier create() => CreatePurchaseNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CreatePurchaseState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CreatePurchaseState>(value),
    );
  }
}

String _$createPurchaseNotifierHash() =>
    r'6b5bd76373ca3a7ba250d9b0140f2bc4f70ba375';

abstract class _$CreatePurchaseNotifier extends $Notifier<CreatePurchaseState> {
  CreatePurchaseState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<CreatePurchaseState, CreatePurchaseState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<CreatePurchaseState, CreatePurchaseState>,
              CreatePurchaseState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
