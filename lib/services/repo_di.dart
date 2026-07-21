import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vyapapp/src/auth/repo/auth_repo.dart';
import 'package:vyapapp/src/home/repo/home_repository.dart';
import 'package:vyapapp/src/bills/repo/bills_repository.dart';
import 'package:vyapapp/src/new_bill/repo/new_bill_repository.dart';
import 'package:vyapapp/src/reports/repo/reports_repository.dart';
import 'package:vyapapp/src/settings/repo/settings_repository.dart';
import 'package:vyapapp/data/remote/network_services.dart';
import 'package:vyapapp/src/main/repo/dropdowns_repository.dart';
import 'package:vyapapp/src/categories/repo/categories_repository.dart';
import 'package:vyapapp/src/products/repo/products_repository.dart';
import 'package:vyapapp/src/customers/repo/customers_repository.dart';
import 'package:vyapapp/src/purchase/repo/purchase_repository.dart';
import 'package:vyapapp/data/local/sembast_services.dart';
import 'package:vyapapp/src/calculation/repo/calculation_repository.dart';

part 'repo_di.g.dart';

/// Repository DI Container
///
/// Add new repository providers here as you create new features.
/// Follow the pattern: abstract repo → impl, wired via Riverpod.

@Riverpod(keepAlive: false)
AuthRepo authRepository(Ref ref) {
  final services = ref.watch(networkServicesProvider);
  return AuthRepoImpl(services);
}

@Riverpod(keepAlive: false)
HomeRepo homeRepository(Ref ref) {
  final services = ref.watch(networkServicesProvider);
  return HomeRepoImpl(services);
}

@Riverpod(keepAlive: false)
BillsRepo billsRepository(Ref ref) {
  final services = ref.watch(networkServicesProvider);
  return BillsRepoImpl(services);
}

@Riverpod(keepAlive: false)
ReportsRepo reportsRepository(Ref ref) {
  final services = ref.watch(networkServicesProvider);
  return ReportsRepoImpl(services);
}

@Riverpod(keepAlive: false)
SettingsRepo settingsRepository(Ref ref) {
  final services = ref.watch(networkServicesProvider);
  return SettingsRepoImpl(services);
}

@Riverpod(keepAlive: false)
NewBillRepo newBillRepository(Ref ref) {
  final services = ref.watch(networkServicesProvider);
  return NewBillRepoImpl(services);
}

@Riverpod(keepAlive: false)
DropdownsRepo dropdownsRepository(Ref ref) {
  final services = ref.watch(networkServicesProvider);
  return DropdownsRepoImpl(services);
}

@Riverpod(keepAlive: false)
CategoriesRepo categoriesRepository(Ref ref) {
  final services = ref.watch(networkServicesProvider);
  return CategoriesRepoImpl(services);
}

@Riverpod(keepAlive: false)
ProductsRepo productsRepository(Ref ref) {
  final services = ref.watch(networkServicesProvider);
  return ProductsRepoImpl(services);
}

@Riverpod(keepAlive: false)
CustomersRepo customersRepository(Ref ref) {
  final services = ref.watch(networkServicesProvider);
  return CustomersRepoImpl(services);
}

@Riverpod(keepAlive: false)
PurchasesRepo purchasesRepository(Ref ref) {
  final services = ref.watch(networkServicesProvider);
  return PurchasesRepoImpl(services);
}

@Riverpod(keepAlive: false)
CalculationRepo calculationRepository(Ref ref) {
  final services = ref.watch(networkServicesProvider);
  final sembast = ref.watch(sembastServicesProvider);
  return CalculationRepoImpl(services, sembast);
}
