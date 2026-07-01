// lib/src/purchase/repo/purchase_repository.dart
import 'package:either_dart/either.dart';
import 'package:vyapapp/data/remote/network_base_services.dart';
import 'package:vyapapp/data/remote/network_services.dart';
import 'package:vyapapp/res/constants/app_constants.dart';
import 'package:vyapapp/utils/helpers/safe_converters.dart';
import '../model/purchase_model.dart';

abstract class PurchasesRepo {
  Future<Either<ResponseError, PurchasesResponseModel>> getPurchases({
    required String startDate,
    required String endDate,
  });

  Future<Either<ResponseError, CreatePurchaseResponseModel>> createPurchase(
    Map<String, dynamic> payload,
  );
}

class PurchasesRepoImpl implements PurchasesRepo {
  final NetworkServices _services;
  PurchasesRepoImpl(this._services);

  @override
  Future<Either<ResponseError, PurchasesResponseModel>> getPurchases({
    required String startDate,
    required String endDate,
  }) async {
    return await _services
        .safe(
          _services.getRequest(
            endPoint: AppConstants.purchase,
            queryParameters: {
              'start_date': startDate,
              'end_date': endDate,
            },
          ),
        )
        .thenRight(_services.checkHttpStatus)
        .thenRight(_services.parseJson)
        .mapRight(
          (right) => PurchasesResponseModel.fromJson(convertToMap(right)),
        );
  }

  @override
  Future<Either<ResponseError, CreatePurchaseResponseModel>> createPurchase(
    Map<String, dynamic> payload,
  ) async {
    return await _services
        .safe(
          _services.postRequest(
            endPoint: AppConstants.purchase,
            parameters: payload,
          ),
        )
        .thenRight(_services.checkHttpStatus)
        .thenRight(_services.parseJson)
        .mapRight(
          (right) => CreatePurchaseResponseModel.fromJson(convertToMap(right)),
        );
  }
}
