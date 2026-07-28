// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calculation_detail_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CalculationDetailNotifier)
final calculationDetailProvider = CalculationDetailNotifierFamily._();

final class CalculationDetailNotifierProvider
    extends
        $NotifierProvider<CalculationDetailNotifier, CalculationDetailState> {
  CalculationDetailNotifierProvider._({
    required CalculationDetailNotifierFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'calculationDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$calculationDetailNotifierHash();

  @override
  String toString() {
    return r'calculationDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  CalculationDetailNotifier create() => CalculationDetailNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CalculationDetailState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CalculationDetailState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is CalculationDetailNotifierProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$calculationDetailNotifierHash() =>
    r'e9e948183b55e000b49ec97c2c926372da74607a';

final class CalculationDetailNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          CalculationDetailNotifier,
          CalculationDetailState,
          CalculationDetailState,
          CalculationDetailState,
          String
        > {
  CalculationDetailNotifierFamily._()
    : super(
        retry: null,
        name: r'calculationDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  CalculationDetailNotifierProvider call(String billId) =>
      CalculationDetailNotifierProvider._(argument: billId, from: this);

  @override
  String toString() => r'calculationDetailProvider';
}

abstract class _$CalculationDetailNotifier
    extends $Notifier<CalculationDetailState> {
  late final _$args = ref.$arg as String;
  String get billId => _$args;

  CalculationDetailState build(String billId);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<CalculationDetailState, CalculationDetailState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<CalculationDetailState, CalculationDetailState>,
              CalculationDetailState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
