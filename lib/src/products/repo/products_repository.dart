// lib/src/products/repo/products_repository.dart
import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:vyapapp/data/remote/network_base_services.dart';
import 'package:vyapapp/data/remote/network_services.dart';
import 'package:vyapapp/res/constants/app_constants.dart';
import 'package:vyapapp/src/auth/model/auth_model.dart';
import 'package:vyapapp/utils/helpers/safe_converters.dart';
import '../model/product_crud_model.dart';

abstract class ProductsRepo {
  Future<Either<ResponseError, ProductResponse>> getProducts({
    required String search,
    int? categoryId,
    required String sort,
    required int page,
    required int pageSize,
  });
  Future<Either<ResponseError, ProductAddResponse>> createProduct(FormData formData);
  Future<Either<ResponseError, ProductAddResponse>> updateProduct(int id, FormData formData);
  Future<Either<ResponseError, ProductDeleteResponse>> deleteProduct(int id);
  Future<Either<ResponseError, CommonResponseModel>> toggleProductStatus(int id, String status);
}

class ProductsRepoImpl implements ProductsRepo {
  final NetworkServices _services;
  ProductsRepoImpl(this._services);

  @override
  Future<Either<ResponseError, ProductResponse>> getProducts({
    required String search,
    int? categoryId,
    required String sort,
    required int page,
    required int pageSize,
  }) async {
    final Map<String, dynamic> queryParameters = {
      if (search.isNotEmpty) 'search': search,
      if (categoryId != null) 'category': categoryId,
      'sort': sort,
      'page': page,
      'page_size': pageSize,
    };

    return await _services
        .safe(_services.getRequest(
          endPoint: AppConstants.products,
          queryParameters: queryParameters,
        ))
        .thenRight(_services.checkHttpStatus)
        .thenRight(_services.parseJson)
        .mapRight((right) => ProductResponse.fromJson(convertToMap(right)));
  }

  @override
  Future<Either<ResponseError, ProductAddResponse>> createProduct(FormData formData) async {
    return await _services
        .safe(_services.multiPartRequest(
          endPoint: AppConstants.products,
          formFields: formData,
        ))
        .thenRight(_services.checkHttpStatus)
        .thenRight(_services.parseJson)
        .mapRight((right) => ProductAddResponse.fromJson(convertToMap(right)));
  }

  @override
  Future<Either<ResponseError, ProductAddResponse>> updateProduct(int id, FormData formData) async {
    formData.fields.add(MapEntry('id', id.toString()));
    return await _services
        .safe(_services.putMultiPartRequest(
          endPoint: AppConstants.products,
          formFields: formData,
        ))
        .thenRight(_services.checkHttpStatus)
        .thenRight(_services.parseJson)
        .mapRight((right) => ProductAddResponse.fromJson(convertToMap(right)));
  }

  @override
  Future<Either<ResponseError, ProductDeleteResponse>> deleteProduct(int id) async {
    return await _services
        .safe(_services.deleteRequest(
          endPoint: AppConstants.products,
          queryParameters: {'id': id},
        ))
        .thenRight(_services.checkHttpStatus)
        .thenRight(_services.parseJson)
        .mapRight((right) => ProductDeleteResponse.fromJson(convertToMap(right)));
  }

  @override
  Future<Either<ResponseError, CommonResponseModel>> toggleProductStatus(int id, String status) async {
    return await _services
        .safe(_services.putRequest(
          endPoint: AppConstants.productStatus,
          parameters: {
            'id': id,
            'status': status,
          },
        ))
        .thenRight(_services.checkHttpStatus)
        .thenRight(_services.parseJson)
        .mapRight((right) => CommonResponseModel.fromJson(convertToMap(right)));
  }
}
