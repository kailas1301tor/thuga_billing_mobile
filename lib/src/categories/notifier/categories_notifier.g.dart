// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'categories_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CategoriesNotifier)
final categoriesProvider = CategoriesNotifierProvider._();

final class CategoriesNotifierProvider
    extends $NotifierProvider<CategoriesNotifier, CategoriesState> {
  CategoriesNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'categoriesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$categoriesNotifierHash();

  @$internal
  @override
  CategoriesNotifier create() => CategoriesNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CategoriesState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CategoriesState>(value),
    );
  }
}

String _$categoriesNotifierHash() =>
    r'd3d57d7524bbf1fd7bfee84ed0cd11b8e27f67ce';

abstract class _$CategoriesNotifier extends $Notifier<CategoriesState> {
  CategoriesState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<CategoriesState, CategoriesState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<CategoriesState, CategoriesState>,
              CategoriesState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
