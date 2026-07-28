// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bill_detail_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(BillDetailNotifier)
final billDetailProvider = BillDetailNotifierFamily._();

final class BillDetailNotifierProvider
    extends $AsyncNotifierProvider<BillDetailNotifier, BillDetailModel> {
  BillDetailNotifierProvider._({
    required BillDetailNotifierFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'billDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$billDetailNotifierHash();

  @override
  String toString() {
    return r'billDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  BillDetailNotifier create() => BillDetailNotifier();

  @override
  bool operator ==(Object other) {
    return other is BillDetailNotifierProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$billDetailNotifierHash() =>
    r'eb930b4f56625e12d277352503ac50c96a800099';

final class BillDetailNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          BillDetailNotifier,
          AsyncValue<BillDetailModel>,
          BillDetailModel,
          FutureOr<BillDetailModel>,
          int
        > {
  BillDetailNotifierFamily._()
    : super(
        retry: null,
        name: r'billDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  BillDetailNotifierProvider call(int id) =>
      BillDetailNotifierProvider._(argument: id, from: this);

  @override
  String toString() => r'billDetailProvider';
}

abstract class _$BillDetailNotifier extends $AsyncNotifier<BillDetailModel> {
  late final _$args = ref.$arg as int;
  int get id => _$args;

  FutureOr<BillDetailModel> build(int id);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<BillDetailModel>, BillDetailModel>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<BillDetailModel>, BillDetailModel>,
              AsyncValue<BillDetailModel>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
