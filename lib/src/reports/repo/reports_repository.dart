// lib/src/reports/repo/reports_repository.dart
import 'package:either_dart/either.dart';
import 'package:vyapapp/data/remote/network_base_services.dart';
import 'package:vyapapp/data/remote/network_services.dart';
import 'package:vyapapp/res/constants/app_constants.dart';
import 'package:vyapapp/utils/helpers/safe_converters.dart';
import '../model/reports_model.dart';

abstract class ReportsRepo {
  Future<Either<ResponseError, ReportsDataModel>> getReportsData(String range);
}

class ReportsRepoImpl implements ReportsRepo {
  final NetworkServices _networkServices;

  ReportsRepoImpl(this._networkServices);

  @override
  Future<Either<ResponseError, ReportsDataModel>> getReportsData(String range) async {
    final now = DateTime.now();
    DateTime startDate = now;
    DateTime endDate = now;

    if (range == 'Today') {
      startDate = now;
      endDate = now;
    } else if (range == 'Yesterday') {
      startDate = now.subtract(const Duration(days: 1));
      endDate = now.subtract(const Duration(days: 1));
    } else if (range == 'Last 7 Days') {
      startDate = now.subtract(const Duration(days: 7));
      endDate = now;
    } else if (range == 'This Month') {
      startDate = DateTime(now.year, now.month, 1);
      endDate = now;
    }

    final startStr = _formatYmd(startDate);
    final endStr = _formatYmd(endDate);

    final result = await _networkServices
        .safe(
          _networkServices.getRequest(
            endPoint: AppConstants.reports,
            queryParameters: {
              'start_date': startStr,
              'end_date': endStr,
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

  String _formatYmd(DateTime date) {
    return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }
}
