// lib/src/customers/repo/customers_repository.dart
import 'package:either_dart/either.dart';
import 'package:vyapapp/data/remote/network_base_services.dart';
import 'package:vyapapp/data/remote/network_services.dart';
import 'package:vyapapp/res/constants/app_constants.dart';
import 'package:vyapapp/utils/helpers/safe_converters.dart';
import '../model/customer_model.dart';

abstract class CustomersRepo {
  Future<Either<ResponseError, CustomerResponse>> getCustomers();
  Future<Either<ResponseError, CustomerAddResponse>> createCustomer(Map<String, dynamic> body);
  Future<Either<ResponseError, CustomerAddResponse>> updateCustomer(int id, Map<String, dynamic> body);
  Future<Either<ResponseError, CustomerDeleteResponse>> deleteCustomer(int id);
}

class CustomersRepoImpl implements CustomersRepo {
  final NetworkServices _services;
  CustomersRepoImpl(this._services);

  @override
  Future<Either<ResponseError, CustomerResponse>> getCustomers() async {
    return await _services
        .safe(_services.getRequest(endPoint: AppConstants.customers))
        .thenRight(_services.checkHttpStatus)
        .thenRight(_services.parseJson)
        .mapRight((right) => CustomerResponse.fromJson(convertToMap(right)));
  }

  @override
  Future<Either<ResponseError, CustomerAddResponse>> createCustomer(Map<String, dynamic> body) async {
    return await _services
        .safe(_services.postRequest(
          endPoint: AppConstants.customers,
          parameters: body,
        ))
        .thenRight(_services.checkHttpStatus)
        .thenRight(_services.parseJson)
        .mapRight((right) => CustomerAddResponse.fromJson(convertToMap(right)));
  }

  @override
  Future<Either<ResponseError, CustomerAddResponse>> updateCustomer(int id, Map<String, dynamic> body) async {
    final updatedBody = Map<String, dynamic>.from(body)..['id'] = id;
    return await _services
        .safe(_services.putRequest(
          endPoint: AppConstants.customers,
          parameters: updatedBody,
        ))
        .thenRight(_services.checkHttpStatus)
        .thenRight(_services.parseJson)
        .mapRight((right) => CustomerAddResponse.fromJson(convertToMap(right)));
  }

  @override
  Future<Either<ResponseError, CustomerDeleteResponse>> deleteCustomer(int id) async {
    return await _services
        .safe(_services.deleteRequest(
          endPoint: AppConstants.customers,
          queryParameters: {'id': id},
        ))
        .thenRight(_services.checkHttpStatus)
        .thenRight(_services.parseJson)
        .mapRight((right) => CustomerDeleteResponse.fromJson(convertToMap(right)));
  }
}
