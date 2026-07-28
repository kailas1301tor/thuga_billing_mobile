import 'package:either_dart/either.dart';
import 'package:flutter/foundation.dart';
import 'package:thuga/data/remote/network_base_services.dart';
import 'package:thuga/data/remote/network_services.dart';
import 'package:thuga/res/constants/app_constants.dart';
import 'package:thuga/utils/helpers/safe_converters.dart';
import '../model/auth_model.dart';

/// Abstract repository for authentication operations.
abstract class AuthRepo {
  Future<Either<ResponseError, AuthModel>> login({
    required String email,
    required String password,
  });


  Future<Either<ResponseError, CommonResponseModel>> register({
    required String email,
    required String password,
    required String companyName,
    required String address,
    required String phoneNumber,
  });

  Future<Either<ResponseError, CommonResponseModel>> logout();
}

/// Concrete implementation of [AuthRepo].
class AuthRepoImpl extends AuthRepo {
  final NetworkServices _networkServices;

  AuthRepoImpl(this._networkServices);

  @override
  Future<Either<ResponseError, AuthModel>> login({
    required String email,
    required String password,
  }) async {
    return await _networkServices
        .safe(
          _networkServices.postRequest(
            endPoint: AppConstants.login,
            parameters: {'email': email, 'password': password},
            isFromAuth: true,
          ),
        )
        .thenRight(_networkServices.checkHttpStatus)
        .thenRight(_networkServices.parseJson)
        .mapRight((right) {
          final resultsMap = convertToMap(right['results']);
          final dataMap = convertToMap(resultsMap['data']);
          debugPrint('🔍 UNWRAPPED LOGIN DATA: $dataMap');
          return AuthModel.fromJson(dataMap);
        });
  }


  @override
  Future<Either<ResponseError, CommonResponseModel>> register({
    required String email,
    required String password,
    required String companyName,
    required String address,
    required String phoneNumber,
  }) async {
    return await _networkServices
        .safe(
          _networkServices.postRequest(
            endPoint: AppConstants.register,
            parameters: {
              'email': email,
              'password': password,
              'company_name': companyName,
              'address': address,
              'phone_number': phoneNumber,
            },
            isFromAuth: true,
          ),
        )
        .thenRight(_networkServices.checkHttpStatus)
        .thenRight(_networkServices.parseJson)
        .mapRight((right) => CommonResponseModel.fromJson(right));
  }

  @override
  Future<Either<ResponseError, CommonResponseModel>> logout() async {
    return await _networkServices
        .safe(_networkServices.postRequest(endPoint: AppConstants.logout))
        .thenRight(_networkServices.checkHttpStatus)
        .thenRight(_networkServices.parseJson)
        .mapRight((right) => CommonResponseModel.fromJson(right));
  }
}
