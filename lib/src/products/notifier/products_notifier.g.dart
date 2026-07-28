// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'products_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ProductsNotifier)
final productsProvider = ProductsNotifierProvider._();

final class ProductsNotifierProvider
    extends $NotifierProvider<ProductsNotifier, ProductsState> {
  ProductsNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'productsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$productsNotifierHash();

  @$internal
  @override
  ProductsNotifier create() => ProductsNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ProductsState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ProductsState>(value),
    );
  }
}

String _$productsNotifierHash() => r'e05ae7fe0952ff612e11eb4e32a5a405c9408d90';

abstract class _$ProductsNotifier extends $Notifier<ProductsState> {
  ProductsState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<ProductsState, ProductsState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ProductsState, ProductsState>,
              ProductsState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
