// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'purchases_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PurchasesNotifier)
final purchasesProvider = PurchasesNotifierProvider._();

final class PurchasesNotifierProvider
    extends $NotifierProvider<PurchasesNotifier, PurchasesState> {
  PurchasesNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'purchasesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$purchasesNotifierHash();

  @$internal
  @override
  PurchasesNotifier create() => PurchasesNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PurchasesState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PurchasesState>(value),
    );
  }
}

String _$purchasesNotifierHash() => r'ebad248e7fb007b54f5ada068b492e4e6666027a';

abstract class _$PurchasesNotifier extends $Notifier<PurchasesState> {
  PurchasesState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<PurchasesState, PurchasesState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<PurchasesState, PurchasesState>,
              PurchasesState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
