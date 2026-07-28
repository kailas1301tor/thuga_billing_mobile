// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calculation_list_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CalculationListNotifier)
final calculationListProvider = CalculationListNotifierProvider._();

final class CalculationListNotifierProvider
    extends $NotifierProvider<CalculationListNotifier, CalculationListState> {
  CalculationListNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'calculationListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$calculationListNotifierHash();

  @$internal
  @override
  CalculationListNotifier create() => CalculationListNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CalculationListState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CalculationListState>(value),
    );
  }
}

String _$calculationListNotifierHash() =>
    r'bce21f78a086e32a9f083f114a0e5463b2b5ce90';

abstract class _$CalculationListNotifier
    extends $Notifier<CalculationListState> {
  CalculationListState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<CalculationListState, CalculationListState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<CalculationListState, CalculationListState>,
              CalculationListState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
