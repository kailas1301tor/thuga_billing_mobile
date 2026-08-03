// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_bill_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(NewBillNotifier)
final newBillProvider = NewBillNotifierProvider._();

final class NewBillNotifierProvider
    extends $NotifierProvider<NewBillNotifier, NewBillState> {
  NewBillNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'newBillProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$newBillNotifierHash();

  @$internal
  @override
  NewBillNotifier create() => NewBillNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NewBillState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NewBillState>(value),
    );
  }
}

String _$newBillNotifierHash() => r'bfcb07b6b0fb4400e8e956480f7e6d3d29b38995';

abstract class _$NewBillNotifier extends $Notifier<NewBillState> {
  NewBillState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<NewBillState, NewBillState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<NewBillState, NewBillState>,
              NewBillState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
