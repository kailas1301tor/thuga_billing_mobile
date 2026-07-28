// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calculation_editor_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CalculationEditorNotifier)
final calculationEditorProvider = CalculationEditorNotifierFamily._();

final class CalculationEditorNotifierProvider
    extends
        $NotifierProvider<CalculationEditorNotifier, CalculationEditorState> {
  CalculationEditorNotifierProvider._({
    required CalculationEditorNotifierFamily super.from,
    required String? super.argument,
  }) : super(
         retry: null,
         name: r'calculationEditorProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$calculationEditorNotifierHash();

  @override
  String toString() {
    return r'calculationEditorProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  CalculationEditorNotifier create() => CalculationEditorNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CalculationEditorState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CalculationEditorState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is CalculationEditorNotifierProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$calculationEditorNotifierHash() =>
    r'5dc05cee113f3ce767fa039da79551588fef7887';

final class CalculationEditorNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          CalculationEditorNotifier,
          CalculationEditorState,
          CalculationEditorState,
          CalculationEditorState,
          String?
        > {
  CalculationEditorNotifierFamily._()
    : super(
        retry: null,
        name: r'calculationEditorProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  CalculationEditorNotifierProvider call(String? billId) =>
      CalculationEditorNotifierProvider._(argument: billId, from: this);

  @override
  String toString() => r'calculationEditorProvider';
}

abstract class _$CalculationEditorNotifier
    extends $Notifier<CalculationEditorState> {
  late final _$args = ref.$arg as String?;
  String? get billId => _$args;

  CalculationEditorState build(String? billId);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<CalculationEditorState, CalculationEditorState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<CalculationEditorState, CalculationEditorState>,
              CalculationEditorState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
