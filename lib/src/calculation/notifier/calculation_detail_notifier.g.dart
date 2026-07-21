// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calculation_detail_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$calculationDetailNotifierHash() =>
    r'e9e948183b55e000b49ec97c2c926372da74607a';

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

abstract class _$CalculationDetailNotifier
    extends BuildlessAutoDisposeNotifier<CalculationDetailState> {
  late final String billId;

  CalculationDetailState build(String billId);
}

/// See also [CalculationDetailNotifier].
@ProviderFor(CalculationDetailNotifier)
const calculationDetailNotifierProvider = CalculationDetailNotifierFamily();

/// See also [CalculationDetailNotifier].
class CalculationDetailNotifierFamily extends Family<CalculationDetailState> {
  /// See also [CalculationDetailNotifier].
  const CalculationDetailNotifierFamily();

  /// See also [CalculationDetailNotifier].
  CalculationDetailNotifierProvider call(String billId) {
    return CalculationDetailNotifierProvider(billId);
  }

  @override
  CalculationDetailNotifierProvider getProviderOverride(
    covariant CalculationDetailNotifierProvider provider,
  ) {
    return call(provider.billId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'calculationDetailNotifierProvider';
}

/// See also [CalculationDetailNotifier].
class CalculationDetailNotifierProvider
    extends
        AutoDisposeNotifierProviderImpl<
          CalculationDetailNotifier,
          CalculationDetailState
        > {
  /// See also [CalculationDetailNotifier].
  CalculationDetailNotifierProvider(String billId)
    : this._internal(
        () => CalculationDetailNotifier()..billId = billId,
        from: calculationDetailNotifierProvider,
        name: r'calculationDetailNotifierProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$calculationDetailNotifierHash,
        dependencies: CalculationDetailNotifierFamily._dependencies,
        allTransitiveDependencies:
            CalculationDetailNotifierFamily._allTransitiveDependencies,
        billId: billId,
      );

  CalculationDetailNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.billId,
  }) : super.internal();

  final String billId;

  @override
  CalculationDetailState runNotifierBuild(
    covariant CalculationDetailNotifier notifier,
  ) {
    return notifier.build(billId);
  }

  @override
  Override overrideWith(CalculationDetailNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: CalculationDetailNotifierProvider._internal(
        () => create()..billId = billId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        billId: billId,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<
    CalculationDetailNotifier,
    CalculationDetailState
  >
  createElement() {
    return _CalculationDetailNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CalculationDetailNotifierProvider && other.billId == billId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, billId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CalculationDetailNotifierRef
    on AutoDisposeNotifierProviderRef<CalculationDetailState> {
  /// The parameter `billId` of this provider.
  String get billId;
}

class _CalculationDetailNotifierProviderElement
    extends
        AutoDisposeNotifierProviderElement<
          CalculationDetailNotifier,
          CalculationDetailState
        >
    with CalculationDetailNotifierRef {
  _CalculationDetailNotifierProviderElement(super.provider);

  @override
  String get billId => (origin as CalculationDetailNotifierProvider).billId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
