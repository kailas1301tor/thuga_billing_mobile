// lib/src/settings/repo/settings_repository.dart
import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vyapapp/data/remote/network_base_services.dart';
import 'package:vyapapp/data/remote/network_services.dart';
import 'package:vyapapp/res/constants/app_constants.dart';
import 'package:vyapapp/src/auth/model/auth_model.dart';
import 'package:vyapapp/utils/helpers/safe_converters.dart';
import '../model/settings_model.dart';
import '../model/company_details_model.dart';

abstract class SettingsRepo {
  Future<Either<ResponseError, SettingsModel>> getSettings();
  Future<Either<ResponseError, SettingsModel>> saveSettings(SettingsModel settings);
  Future<Either<ResponseError, CompanyDetailsModel>> getCompanyDetails(int companyId);
  Future<Either<ResponseError, CommonResponseModel>> updateCompanyDetails({
    required int companyId,
    required String email,
    String? password,
    required String companyName,
    required String address,
    required String phoneNumber,
    required String startWorkingHour,
    required String endWorkingHour,
  });
}

class SettingsRepoImpl implements SettingsRepo {
  final NetworkServices _networkServices;

  SettingsRepoImpl(this._networkServices);

  static const _kStoreNameKey = 'pref_store_name';
  static const _kEmailKey = 'pref_email';
  static const _kAutoPrintKey = 'pref_auto_print';
  static const _kDefaultPaymentMethodKey = 'pref_default_payment';
  static const _kTaxRateKey = 'pref_tax_rate';

  String _normalizeStoreName(String? value) {
    final trimmed = value?.trim() ?? '';
    if (trimmed.isEmpty) return 'Thuka';

    final normalized = trimmed.toLowerCase();
    if (normalized == 'tortilon bakery' || normalized == 'tortillon') {
      return 'Thuka';
    }

    return trimmed;
  }

  @override
  Future<Either<ResponseError, SettingsModel>> getSettings() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final storeName = _normalizeStoreName(prefs.getString(_kStoreNameKey));
      final email = prefs.getString(_kEmailKey) ?? 'contact@thuka.com';
      final autoPrint = prefs.getBool(_kAutoPrintKey) ?? false;
      final defaultPayment = prefs.getString(_kDefaultPaymentMethodKey) ?? 'Cash';
      final taxRate = prefs.getDouble(_kTaxRateKey) ?? 5.0;

      return Right(
        SettingsModel(
          storeName: storeName,
          email: email,
          autoPrint: autoPrint,
          defaultPaymentMethod: defaultPayment,
          taxRate: taxRate,
        ),
      );
    } catch (e) {
      return Left(
        ResponseError(
          message: 'Failed to load local preferences: $e',
          key: ApiErrorTypes.oops,
        ),
      );
    }
  }

  @override
  Future<Either<ResponseError, SettingsModel>> saveSettings(SettingsModel settings) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      await prefs.setString(_kStoreNameKey, settings.storeName);
      await prefs.setString(_kEmailKey, settings.email);
      await prefs.setBool(_kAutoPrintKey, settings.autoPrint);
      await prefs.setString(_kDefaultPaymentMethodKey, settings.defaultPaymentMethod);
      await prefs.setDouble(_kTaxRateKey, settings.taxRate);

      return Right(settings);
    } catch (e) {
      return Left(
        ResponseError(
          message: 'Failed to save local preferences: $e',
          key: ApiErrorTypes.oops,
        ),
      );
    }
  }

  @override
  Future<Either<ResponseError, CompanyDetailsModel>> getCompanyDetails(int companyId) async {
    final result = await _networkServices
        .safe(
          _networkServices.getRequest(
            endPoint: AppConstants.companyDetails,
            queryParameters: {'id': companyId},
          ),
        )
        .thenRight(_networkServices.checkHttpStatus)
        .thenRight(_networkServices.parseJson)
        .mapRight((right) {
          final results = convertToMap(right['results']);
          final data = convertToMap(results['data']);
          return CompanyDetailsModel.fromJson(data);
        });

    return result.fold(
      (left) {
        debugPrint('🔴 API ERROR fetching company details: ${left.message}. Loading mock fallback.');
        return Right(_getMockCompany(companyId));
      },
      (right) => Right(right),
    );
  }

  CompanyDetailsModel _getMockCompany(int id) {
    return CompanyDetailsModel(
      id: id,
      companyName: 'Thuka',
      status: 'Active',
      address: 'thrissur',
      phoneNumber: '9987654656',
      isActive: true,
      email: 'contact@thuka.com',
      startWorkingHour: '00:00:00',
      endWorkingHour: '12:00:00',
    );
  }

  @override
  Future<Either<ResponseError, CommonResponseModel>> updateCompanyDetails({
    required int companyId,
    required String email,
    String? password,
    required String companyName,
    required String address,
    required String phoneNumber,
    required String startWorkingHour,
    required String endWorkingHour,
  }) async {
    final Map<String, dynamic> params = {
      'id': companyId,
      'email': email,
      'company_name': companyName,
      'address': address,
      'phone_number': phoneNumber,
      'start_working_hour': startWorkingHour,
      'end_working_hour': endWorkingHour,
    };
    if (password != null && password.isNotEmpty) {
      params['password'] = password;
    }

    return await _networkServices
        .safe(
          _networkServices.putRequest(
            endPoint: AppConstants.companyDetails,
            parameters: params,
          ),
        )
        .thenRight(_networkServices.checkHttpStatus)
        .thenRight(_networkServices.parseJson)
        .mapRight((right) => CommonResponseModel.fromJson(right));
  }
}
