// lib/src/calculation/repo/calculation_repository.dart
import 'package:either_dart/either.dart';
import 'package:thuga/data/local/sembast_services.dart';
import 'package:thuga/data/remote/network_base_services.dart';
import 'package:thuga/data/remote/network_services.dart';
import 'package:thuga/res/constants/app_constants.dart';
import 'package:thuga/utils/helpers/safe_converters.dart';

import '../model/calculation_bill_model.dart';
import '../model/calculation_catalog_model.dart';

abstract class CalculationRepo {
  Future<List<CalculationBillModel>> getAllBills();
  Future<CalculationBillModel?> getBill(String id);
  Future<void> saveBill(CalculationBillModel bill);
  Future<void> deleteBill(String id);
  Future<Either<ResponseError, CalculationCatalogResponse>> getCatalog({
    String? search,
    int? categoryId,
    int page = 1,
    int pageSize = 50,
  });
}

class CalculationRepoImpl implements CalculationRepo {
  CalculationRepoImpl(this._services, this._sembast);

  final NetworkServices _services;
  final SembastServices _sembast;

  Future<void> _ensureDb() async {
    try {
      await _sembast.initialize();
    } catch (_) {}
  }

  @override
  Future<List<CalculationBillModel>> getAllBills() async {
    await _ensureDb();
    final records = await _sembast.getAllCalculationBills();
    final bills = records
        .map((e) => CalculationBillModel.fromJson(e))
        .toList()
      ..sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
    return bills;
  }

  @override
  Future<CalculationBillModel?> getBill(String id) async {
    await _ensureDb();
    final record = await _sembast.getCalculationBill(id);
    if (record == null) return null;
    return CalculationBillModel.fromJson(record);
  }

  @override
  Future<void> saveBill(CalculationBillModel bill) async {
    await _ensureDb();
    await _sembast.saveCalculationBill(bill.toJson());
  }

  @override
  Future<void> deleteBill(String id) async {
    await _ensureDb();
    await _sembast.deleteCalculationBill(id);
  }

  @override
  Future<Either<ResponseError, CalculationCatalogResponse>> getCatalog({
    String? search,
    int? categoryId,
    int page = 1,
    int pageSize = 50,
  }) async {
    return await _services
        .safe(
          _services.getRequest(
            endPoint: AppConstants.categoriesWithProducts,
            queryParameters: {
              if (search != null && search.isNotEmpty) 'search': search,
              if (categoryId != null) 'category_id': categoryId,
              'page': page,
              'page_size': pageSize,
            },
          ),
        )
        .thenRight(_services.checkHttpStatus)
        .thenRight(_services.parseJson)
        .mapRight(
          (right) => CalculationCatalogResponse.fromJson(convertToMap(right)),
        );
  }
}
