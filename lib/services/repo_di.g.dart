// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repo_di.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Repository DI Container
///
/// Add new repository providers here as you create new features.
/// Follow the pattern: abstract repo → impl, wired via Riverpod.

@ProviderFor(authRepository)
final authRepositoryProvider = AuthRepositoryProvider._();

/// Repository DI Container
///
/// Add new repository providers here as you create new features.
/// Follow the pattern: abstract repo → impl, wired via Riverpod.

final class AuthRepositoryProvider
    extends $FunctionalProvider<AuthRepo, AuthRepo, AuthRepo>
    with $Provider<AuthRepo> {
  /// Repository DI Container
  ///
  /// Add new repository providers here as you create new features.
  /// Follow the pattern: abstract repo → impl, wired via Riverpod.
  AuthRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authRepositoryHash();

  @$internal
  @override
  $ProviderElement<AuthRepo> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AuthRepo create(Ref ref) {
    return authRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuthRepo value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuthRepo>(value),
    );
  }
}

String _$authRepositoryHash() => r'557c1b251dafff09351b2df872269c1c2b2b8440';

@ProviderFor(homeRepository)
final homeRepositoryProvider = HomeRepositoryProvider._();

final class HomeRepositoryProvider
    extends $FunctionalProvider<HomeRepo, HomeRepo, HomeRepo>
    with $Provider<HomeRepo> {
  HomeRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'homeRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$homeRepositoryHash();

  @$internal
  @override
  $ProviderElement<HomeRepo> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  HomeRepo create(Ref ref) {
    return homeRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(HomeRepo value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<HomeRepo>(value),
    );
  }
}

String _$homeRepositoryHash() => r'2faba056fd222c0682a46a942b08605ec055b643';

@ProviderFor(billsRepository)
final billsRepositoryProvider = BillsRepositoryProvider._();

final class BillsRepositoryProvider
    extends $FunctionalProvider<BillsRepo, BillsRepo, BillsRepo>
    with $Provider<BillsRepo> {
  BillsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'billsRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$billsRepositoryHash();

  @$internal
  @override
  $ProviderElement<BillsRepo> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  BillsRepo create(Ref ref) {
    return billsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BillsRepo value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BillsRepo>(value),
    );
  }
}

String _$billsRepositoryHash() => r'1d3ea7b54c237ef6ef44dd59dde14d29a674cea8';

@ProviderFor(reportsRepository)
final reportsRepositoryProvider = ReportsRepositoryProvider._();

final class ReportsRepositoryProvider
    extends $FunctionalProvider<ReportsRepo, ReportsRepo, ReportsRepo>
    with $Provider<ReportsRepo> {
  ReportsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'reportsRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$reportsRepositoryHash();

  @$internal
  @override
  $ProviderElement<ReportsRepo> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ReportsRepo create(Ref ref) {
    return reportsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ReportsRepo value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ReportsRepo>(value),
    );
  }
}

String _$reportsRepositoryHash() => r'328f64516b575bc372c8087fe6a45bbf8cd14183';

@ProviderFor(settingsRepository)
final settingsRepositoryProvider = SettingsRepositoryProvider._();

final class SettingsRepositoryProvider
    extends $FunctionalProvider<SettingsRepo, SettingsRepo, SettingsRepo>
    with $Provider<SettingsRepo> {
  SettingsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'settingsRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$settingsRepositoryHash();

  @$internal
  @override
  $ProviderElement<SettingsRepo> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SettingsRepo create(Ref ref) {
    return settingsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SettingsRepo value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SettingsRepo>(value),
    );
  }
}

String _$settingsRepositoryHash() =>
    r'a8859e4bcdba98588e34d133c80d61876f852845';

@ProviderFor(newBillRepository)
final newBillRepositoryProvider = NewBillRepositoryProvider._();

final class NewBillRepositoryProvider
    extends $FunctionalProvider<NewBillRepo, NewBillRepo, NewBillRepo>
    with $Provider<NewBillRepo> {
  NewBillRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'newBillRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$newBillRepositoryHash();

  @$internal
  @override
  $ProviderElement<NewBillRepo> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  NewBillRepo create(Ref ref) {
    return newBillRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NewBillRepo value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NewBillRepo>(value),
    );
  }
}

String _$newBillRepositoryHash() => r'df41f13882a1177b6db710c5ef7c7c0ed1db1230';

@ProviderFor(dropdownsRepository)
final dropdownsRepositoryProvider = DropdownsRepositoryProvider._();

final class DropdownsRepositoryProvider
    extends $FunctionalProvider<DropdownsRepo, DropdownsRepo, DropdownsRepo>
    with $Provider<DropdownsRepo> {
  DropdownsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dropdownsRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dropdownsRepositoryHash();

  @$internal
  @override
  $ProviderElement<DropdownsRepo> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  DropdownsRepo create(Ref ref) {
    return dropdownsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DropdownsRepo value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DropdownsRepo>(value),
    );
  }
}

String _$dropdownsRepositoryHash() =>
    r'52a12124c178bbdd4c5fb5b3bdaf17048a5d45ca';

@ProviderFor(categoriesRepository)
final categoriesRepositoryProvider = CategoriesRepositoryProvider._();

final class CategoriesRepositoryProvider
    extends $FunctionalProvider<CategoriesRepo, CategoriesRepo, CategoriesRepo>
    with $Provider<CategoriesRepo> {
  CategoriesRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'categoriesRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$categoriesRepositoryHash();

  @$internal
  @override
  $ProviderElement<CategoriesRepo> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  CategoriesRepo create(Ref ref) {
    return categoriesRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CategoriesRepo value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CategoriesRepo>(value),
    );
  }
}

String _$categoriesRepositoryHash() =>
    r'4fa4e24b107065a6968704c908f363f22d59021d';

@ProviderFor(productsRepository)
final productsRepositoryProvider = ProductsRepositoryProvider._();

final class ProductsRepositoryProvider
    extends $FunctionalProvider<ProductsRepo, ProductsRepo, ProductsRepo>
    with $Provider<ProductsRepo> {
  ProductsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'productsRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$productsRepositoryHash();

  @$internal
  @override
  $ProviderElement<ProductsRepo> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ProductsRepo create(Ref ref) {
    return productsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ProductsRepo value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ProductsRepo>(value),
    );
  }
}

String _$productsRepositoryHash() =>
    r'404d8fab5faae58e4cf8bbd3c658d4d26973442f';

@ProviderFor(customersRepository)
final customersRepositoryProvider = CustomersRepositoryProvider._();

final class CustomersRepositoryProvider
    extends $FunctionalProvider<CustomersRepo, CustomersRepo, CustomersRepo>
    with $Provider<CustomersRepo> {
  CustomersRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'customersRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$customersRepositoryHash();

  @$internal
  @override
  $ProviderElement<CustomersRepo> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  CustomersRepo create(Ref ref) {
    return customersRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CustomersRepo value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CustomersRepo>(value),
    );
  }
}

String _$customersRepositoryHash() =>
    r'e94e6ed5b7093d927d05c6edde670208c104cacc';

@ProviderFor(purchasesRepository)
final purchasesRepositoryProvider = PurchasesRepositoryProvider._();

final class PurchasesRepositoryProvider
    extends $FunctionalProvider<PurchasesRepo, PurchasesRepo, PurchasesRepo>
    with $Provider<PurchasesRepo> {
  PurchasesRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'purchasesRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$purchasesRepositoryHash();

  @$internal
  @override
  $ProviderElement<PurchasesRepo> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  PurchasesRepo create(Ref ref) {
    return purchasesRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PurchasesRepo value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PurchasesRepo>(value),
    );
  }
}

String _$purchasesRepositoryHash() =>
    r'ed26aee103fa775d51db2e417645bba9878b1e29';

@ProviderFor(calculationRepository)
final calculationRepositoryProvider = CalculationRepositoryProvider._();

final class CalculationRepositoryProvider
    extends
        $FunctionalProvider<CalculationRepo, CalculationRepo, CalculationRepo>
    with $Provider<CalculationRepo> {
  CalculationRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'calculationRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$calculationRepositoryHash();

  @$internal
  @override
  $ProviderElement<CalculationRepo> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  CalculationRepo create(Ref ref) {
    return calculationRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CalculationRepo value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CalculationRepo>(value),
    );
  }
}

String _$calculationRepositoryHash() =>
    r'4d71f63cd9d78f589555d12c62c5c011e4af949f';
