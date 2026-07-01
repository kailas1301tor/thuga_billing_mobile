// lib/src/bills/repo/bills_repository.dart
import 'package:either_dart/either.dart';
import 'package:vyapapp/data/remote/network_base_services.dart';
import 'package:vyapapp/data/remote/network_services.dart';
import 'package:vyapapp/res/constants/app_constants.dart';
import '../model/bill_model.dart';
import '../model/bill_detail_model.dart';

abstract class BillsRepo {
  Future<Either<ResponseError, BillsResponseModel>> getBills({required String dateFilter});
  Future<Either<ResponseError, BillDetailResponseModel>> getBillDetail(int id);
}

class BillsRepoImpl implements BillsRepo {
  final NetworkServices _networkServices;

  BillsRepoImpl(this._networkServices);

  @override
  Future<Either<ResponseError, BillsResponseModel>> getBills({required String dateFilter}) async {
    return await _networkServices
        .safe(
          _networkServices.getRequest(
            endPoint: AppConstants.bills,
            queryParameters: {
              'date': dateFilter,
            },
          ),
        )
        .thenRight(_networkServices.checkHttpStatus)
        .thenRight(_networkServices.parseJson)
        .mapRight((right) => BillsResponseModel.fromJson(right));
  }

  @override
  Future<Either<ResponseError, BillDetailResponseModel>> getBillDetail(int id) async {
    return await _networkServices
        .safe(
          _networkServices.getRequest(
            endPoint: AppConstants.bills,
            queryParameters: {
              'id': id.toString(),
            },
          ),
        )
        .thenRight(_networkServices.checkHttpStatus)
        .thenRight(_networkServices.parseJson)
        .mapRight((right) => BillDetailResponseModel.fromJson(right));
  }
}
