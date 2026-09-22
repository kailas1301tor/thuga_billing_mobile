// lib/src/bills/repo/bills_repository.dart
import 'package:either_dart/either.dart';
import 'package:thuga/data/remote/network_base_services.dart';
import 'package:thuga/data/remote/network_services.dart';
import 'package:thuga/res/constants/app_constants.dart';
import 'package:thuga/src/auth/model/auth_model.dart';
import 'package:thuga/utils/helpers/safe_converters.dart';
import '../model/bill_model.dart';
import '../model/bill_detail_model.dart';

abstract class BillsRepo {
  Future<Either<ResponseError, BillsResponseModel>> getBills({
    required String startDate,
    required String endDate,
    String? status,
    required String search,
    required int page,
    required int pageSize,
  });
  Future<Either<ResponseError, BillDetailResponseModel>> getBillDetail(int id);
  Future<Either<ResponseError, CommonResponseModel>> updateBillPaymentStatus({
    required int id,
    required String paymentStatus,
  });
}

class BillsRepoImpl implements BillsRepo {
  final NetworkServices _networkServices;

  BillsRepoImpl(this._networkServices);

  @override
  Future<Either<ResponseError, BillsResponseModel>> getBills({
    required String startDate,
    required String endDate,
    String? status,
    required String search,
    required int page,
    required int pageSize,
  }) async {
    final queryParams = <String, dynamic>{
      'start_date': startDate,
      'end_date': endDate,
      'search': search,
      'page': page,
      'page_size': pageSize,
    };
    if (status != null && status.isNotEmpty && status != 'All') {
      queryParams['status'] = status;
    }

    return await _networkServices
        .safe(
          _networkServices.getRequest(
            endPoint: AppConstants.bills,
            queryParameters: queryParams,
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

  @override
  Future<Either<ResponseError, CommonResponseModel>> updateBillPaymentStatus({
    required int id,
    required String paymentStatus,
  }) async {
    return await _networkServices
        .safe(
          _networkServices.putRequest(
            endPoint: AppConstants.billPaymentStatus,
            parameters: {
              'id': id,
              'payment_status': paymentStatus,
            },
          ),
        )
        .thenRight(_networkServices.checkHttpStatus)
        .thenRight(_networkServices.parseJson)
        .mapRight((right) => CommonResponseModel.fromJson(convertToMap(right)));
  }
}
