// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calculation_editor_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$calculationEditorNotifierHash() =>
    r'5dc05cee113f3ce767fa039da79551588fef7887';

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

abstract class _$CalculationEditorNotifier
    extends BuildlessAutoDisposeNotifier<CalculationEditorState> {
  late final String? billId;

  CalculationEditorState build(String? billId);
}

/// See also [CalculationEditorNotifier].
@ProviderFor(CalculationEditorNotifier)
const calculationEditorNotifierProvider = CalculationEditorNotifierFamily();

/// See also [CalculationEditorNotifier].
class CalculationEditorNotifierFamily extends Family<CalculationEditorState> {
  /// See also [CalculationEditorNotifier].
  const CalculationEditorNotifierFamily();

  /// See also [CalculationEditorNotifier].
  CalculationEditorNotifierProvider call(String? billId) {
    return CalculationEditorNotifierProvider(billId);
  }

  @override
  CalculationEditorNotifierProvider getProviderOverride(
    covariant CalculationEditorNotifierProvider provider,
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
  String? get name => r'calculationEditorNotifierProvider';
}

/// See also [CalculationEditorNotifier].
class CalculationEditorNotifierProvider
    extends
        AutoDisposeNotifierProviderImpl<
          CalculationEditorNotifier,
          CalculationEditorState
        > {
  /// See also [CalculationEditorNotifier].
  CalculationEditorNotifierProvider(String? billId)
    : this._internal(
        () => CalculationEditorNotifier()..billId = billId,
        from: calculationEditorNotifierProvider,
        name: r'calculationEditorNotifierProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$calculationEditorNotifierHash,
        dependencies: CalculationEditorNotifierFamily._dependencies,
        allTransitiveDependencies:
            CalculationEditorNotifierFamily._allTransitiveDependencies,
        billId: billId,
      );

  CalculationEditorNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.billId,
  }) : super.internal();

  final String? billId;

  @override
  CalculationEditorState runNotifierBuild(
    covariant CalculationEditorNotifier notifier,
  ) {
    return notifier.build(billId);
  }

  @override
  Override overrideWith(CalculationEditorNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: CalculationEditorNotifierProvider._internal(
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
    CalculationEditorNotifier,
    CalculationEditorState
  >
  createElement() {
    return _CalculationEditorNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CalculationEditorNotifierProvider && other.billId == billId;
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
mixin CalculationEditorNotifierRef
    on AutoDisposeNotifierProviderRef<CalculationEditorState> {
  /// The parameter `billId` of this provider.
  String? get billId;
}

class _CalculationEditorNotifierProviderElement
    extends
        AutoDisposeNotifierProviderElement<
          CalculationEditorNotifier,
          CalculationEditorState
        >
    with CalculationEditorNotifierRef {
  _CalculationEditorNotifierProviderElement(super.provider);

  @override
  String? get billId => (origin as CalculationEditorNotifierProvider).billId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
