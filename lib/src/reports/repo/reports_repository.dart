// lib/src/reports/repo/reports_repository.dart
import 'package:either_dart/either.dart';
import 'package:thuga/data/remote/network_base_services.dart';
import 'package:thuga/data/remote/network_services.dart';
import 'package:thuga/res/constants/app_constants.dart';
import 'package:thuga/utils/helpers/safe_converters.dart';
import '../model/reports_model.dart';

abstract class ReportsRepo {
  Future<Either<ResponseError, ReportsDataModel>> getReportsData({
    required String startDate,
    required String endDate,
  });
}

class ReportsRepoImpl implements ReportsRepo {
  final NetworkServices _networkServices;

  ReportsRepoImpl(this._networkServices);

  @override
  Future<Either<ResponseError, ReportsDataModel>> getReportsData({
    required String startDate,
    required String endDate,
  }) async {
    final result = await _networkServices
        .safe(
          _networkServices.getRequest(
            endPoint: AppConstants.reports,
            queryParameters: {
              'start_date': startDate,
              'end_date': endDate,
            },
          ),
        )
        .thenRight(_networkServices.checkHttpStatus)
        .thenRight(_networkServices.parseJson)
        .mapRight((right) {
          final results = convertToMap(right['results']);
          final data = convertToMap(results['data']);
          return ReportsDataModel.fromJson(data);
        });

    return result;
  }
}
