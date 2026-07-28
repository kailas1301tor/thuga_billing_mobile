// lib/src/main/repo/dropdowns_repository.dart
import 'package:either_dart/either.dart';
import 'package:flutter/foundation.dart';
import 'package:thuga/data/remote/network_base_services.dart';
import 'package:thuga/data/remote/network_services.dart';
import 'package:thuga/res/constants/app_constants.dart';
import 'package:thuga/utils/helpers/safe_converters.dart';
import '../model/dropdown_model.dart';

abstract class DropdownsRepo {
  Future<Either<ResponseError, DropdownsDataModel>> getDropdowns();
}

class DropdownsRepoImpl implements DropdownsRepo {
  final NetworkServices _services;
  DropdownsRepoImpl(this._services);

  @override
  Future<Either<ResponseError, DropdownsDataModel>> getDropdowns() async {
    return await _services
        .safe(_services.getRequest(endPoint: AppConstants.dropdowns))
        .thenRight(_services.checkHttpStatus)
        .thenRight(_services.parseJson)
        .mapRight((right) {
          final resultsMap = convertToMap(right['results']);
          final dataMap = convertToMap(resultsMap['data']);
          debugPrint('🟢 Dropdowns fetched successfully');
          return DropdownsDataModel.fromJson(dataMap);
        });
  }
}
