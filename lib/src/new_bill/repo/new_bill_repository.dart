// lib/src/new_bill/repo/new_bill_repository.dart
import 'package:either_dart/either.dart';
import 'package:vyapapp/data/remote/network_base_services.dart';
import 'package:vyapapp/data/remote/network_services.dart';
import 'package:vyapapp/res/constants/app_constants.dart';
import 'package:vyapapp/utils/helpers/safe_converters.dart';
import '../model/new_bill_model.dart';

abstract class NewBillRepo {
  Future<Either<ResponseError, CategoriesWithProductsResponse>> getCategoriesWithProducts({
    int page = 1,
    int pageSize = 100,
  });
  Future<Either<ResponseError, BillResponse>> createBill(Map<String, dynamic> payload);
}

class NewBillRepoImpl implements NewBillRepo {
  final NetworkServices _services;
  NewBillRepoImpl(this._services);

  @override
  Future<Either<ResponseError, CategoriesWithProductsResponse>> getCategoriesWithProducts({
    int page = 1,
    int pageSize = 100,
  }) async {
    return await _services
        .safe(_services.getRequest(
          endPoint: AppConstants.categoriesWithProducts,
          queryParameters: {
            'page': page,
            'page_size': pageSize,
          },
        ))
        .thenRight(_services.checkHttpStatus)
        .thenRight(_services.parseJson)
        .mapRight((right) => CategoriesWithProductsResponse.fromJson(convertToMap(right)));
  }

  @override
  Future<Either<ResponseError, BillResponse>> createBill(Map<String, dynamic> payload) async {
    return await _services
        .safe(_services.postRequest(
          endPoint: AppConstants.bills,
          parameters: payload,
        ))
        .thenRight(_services.checkHttpStatus)
        .thenRight(_services.parseJson)
        .mapRight((right) => BillResponse.fromJson(convertToMap(right)));
  }
}
