// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bills_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(BillsNotifier)
final billsProvider = BillsNotifierProvider._();

final class BillsNotifierProvider
    extends $NotifierProvider<BillsNotifier, BillsState> {
  BillsNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'billsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$billsNotifierHash();

  @$internal
  @override
  BillsNotifier create() => BillsNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BillsState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BillsState>(value),
    );
  }
}

String _$billsNotifierHash() => r'dc9a4e86d08a0adac11c421fc7b0e3a0138f4d07';

abstract class _$BillsNotifier extends $Notifier<BillsState> {
  BillsState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<BillsState, BillsState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<BillsState, BillsState>,
              BillsState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
