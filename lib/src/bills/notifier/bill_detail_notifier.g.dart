// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bill_detail_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$billDetailNotifierHash() =>
    r'eb930b4f56625e12d277352503ac50c96a800099';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$BillDetailNotifier
    extends BuildlessAutoDisposeAsyncNotifier<BillDetailModel> {
  late final int id;

  FutureOr<BillDetailModel> build(int id);
}

/// See also [BillDetailNotifier].
@ProviderFor(BillDetailNotifier)
const billDetailNotifierProvider = BillDetailNotifierFamily();

/// See also [BillDetailNotifier].
class BillDetailNotifierFamily extends Family<AsyncValue<BillDetailModel>> {
  /// See also [BillDetailNotifier].
  const BillDetailNotifierFamily();

  /// See also [BillDetailNotifier].
  BillDetailNotifierProvider call(int id) {
    return BillDetailNotifierProvider(id);
  }

  @override
  BillDetailNotifierProvider getProviderOverride(
    covariant BillDetailNotifierProvider provider,
  ) {
    return call(provider.id);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'billDetailNotifierProvider';
}

/// See also [BillDetailNotifier].
class BillDetailNotifierProvider
    extends
        AutoDisposeAsyncNotifierProviderImpl<
          BillDetailNotifier,
          BillDetailModel
        > {
  /// See also [BillDetailNotifier].
  BillDetailNotifierProvider(int id)
    : this._internal(
        () => BillDetailNotifier()..id = id,
        from: billDetailNotifierProvider,
        name: r'billDetailNotifierProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$billDetailNotifierHash,
        dependencies: BillDetailNotifierFamily._dependencies,
        allTransitiveDependencies:
            BillDetailNotifierFamily._allTransitiveDependencies,
        id: id,
      );

  BillDetailNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final int id;

  @override
  FutureOr<BillDetailModel> runNotifierBuild(
    covariant BillDetailNotifier notifier,
  ) {
    return notifier.build(id);
  }

  @override
  Override overrideWith(BillDetailNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: BillDetailNotifierProvider._internal(
        () => create()..id = id,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<BillDetailNotifier, BillDetailModel>
  createElement() {
    return _BillDetailNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is BillDetailNotifierProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin BillDetailNotifierRef
    on AutoDisposeAsyncNotifierProviderRef<BillDetailModel> {
  /// The parameter `id` of this provider.
  int get id;
}

class _BillDetailNotifierProviderElement
    extends
        AutoDisposeAsyncNotifierProviderElement<
          BillDetailNotifier,
          BillDetailModel
        >
    with BillDetailNotifierRef {
  _BillDetailNotifierProviderElement(super.provider);

  @override
  int get id => (origin as BillDetailNotifierProvider).id;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
