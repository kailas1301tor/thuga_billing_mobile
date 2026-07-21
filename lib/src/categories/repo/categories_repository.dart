// lib/src/categories/repo/categories_repository.dart
import 'package:either_dart/either.dart';
import 'package:vyapapp/data/remote/network_base_services.dart';
import 'package:vyapapp/data/remote/network_services.dart';
import 'package:vyapapp/res/constants/app_constants.dart';
import 'package:vyapapp/utils/helpers/safe_converters.dart';
import '../model/category_model.dart';

abstract class CategoriesRepo {
  Future<Either<ResponseError, CategoryResponse>> getCategories({
    required String search,
    required int page,
    required int pageSize,
  });
  Future<Either<ResponseError, CategoryAddResponse>> createCategory(String name);
  Future<Either<ResponseError, CategoryAddResponse>> updateCategory(int id, String name);
  Future<Either<ResponseError, CategoryDeleteResponse>> deleteCategory(int id);
}

class CategoriesRepoImpl implements CategoriesRepo {
  final NetworkServices _services;
  CategoriesRepoImpl(this._services);

  @override
  Future<Either<ResponseError, CategoryResponse>> getCategories({
    required String search,
    required int page,
    required int pageSize,
  }) async {
    final queryParameters = <String, dynamic>{
      'search': search,
      'page': page,
      'page_size': pageSize,
    };

    return await _services
        .safe(_services.getRequest(
          endPoint: AppConstants.categories,
          queryParameters: queryParameters,
        ))
        .thenRight(_services.checkHttpStatus)
        .thenRight(_services.parseJson)
        .mapRight((right) => CategoryResponse.fromJson(convertToMap(right)));
  }

  @override
  Future<Either<ResponseError, CategoryAddResponse>> createCategory(String name) async {
    return await _services
        .safe(_services.postRequest(
          endPoint: AppConstants.categories,
          parameters: {'name': name},
        ))
        .thenRight(_services.checkHttpStatus)
        .thenRight(_services.parseJson)
        .mapRight((right) => CategoryAddResponse.fromJson(convertToMap(right)));
  }

  @override
  Future<Either<ResponseError, CategoryAddResponse>> updateCategory(int id, String name) async {
    return await _services
        .safe(_services.putRequest(
          endPoint: AppConstants.categories,
          parameters: {'id': id, 'name': name},
        ))
        .thenRight(_services.checkHttpStatus)
        .thenRight(_services.parseJson)
        .mapRight((right) => CategoryAddResponse.fromJson(convertToMap(right)));
  }

  @override
  Future<Either<ResponseError, CategoryDeleteResponse>> deleteCategory(int id) async {
    return await _services
        .safe(_services.deleteRequest(
          endPoint: AppConstants.categories,
          queryParameters: {'id': id},
        ))
        .thenRight(_services.checkHttpStatus)
        .thenRight(_services.parseJson)
        .mapRight((right) => CategoryDeleteResponse.fromJson(convertToMap(right)));
  }
}
