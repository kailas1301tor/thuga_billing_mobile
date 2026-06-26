// lib/src/home/repo/home_repository.dart
import 'package:either_dart/either.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vyapapp/data/remote/network_base_services.dart';
import 'package:vyapapp/data/remote/network_services.dart';
import 'package:vyapapp/res/constants/app_constants.dart';
import 'package:vyapapp/res/constants/string_constants.dart';
import 'package:vyapapp/utils/helpers/safe_converters.dart';

import '../model/home_dashboard_model.dart';
import '../model/home_recent_bill_model.dart';
import '../model/home_top_product_model.dart';

abstract class HomeRepo {
  Future<Either<ResponseError, HomeDashboardModel>> getDashboard();
}

class HomeRepoImpl implements HomeRepo {
  final NetworkServices _networkServices;

  HomeRepoImpl(this._networkServices);

  @override
  Future<Either<ResponseError, HomeDashboardModel>> getDashboard() async {
    // 1. Fetch store name from local settings
    String shopName = 'Tortilon Bakery';
    try {
      final prefs = await SharedPreferences.getInstance();
      shopName = prefs.getString('pref_store_name') ?? 'Tortilon Bakery';
    } catch (_) {}

    // 2. Call API
    final result = await _networkServices
        .safe(
          _networkServices.getRequest(
            endPoint: AppConstants.dashboard,
          ),
        )
        .thenRight(_networkServices.checkHttpStatus)
        .thenRight(_networkServices.parseJson)
        .mapRight((right) {
          final results = convertToMap(right['results']);
          final data = convertToMap(results['data']);

          // Fetch top products list
          final topProductsList = convertToList(data['top_products_today']);
          final topProducts = List.generate(
            topProductsList.length,
            (index) => HomeTopProductModel.fromJson(convertToMap(topProductsList[index]), index),
          );

          // Fetch recent bills list
          final recentBillsList = convertToList(data['recent_bills']);
          final recentBills = recentBillsList.map((b) {
            final billMap = convertToMap(b);
            final customerId = billMap['customer'] != null ? convertToInt(billMap['customer']) : null;
            final customerName = customerId != null ? 'Customer #$customerId' : Strings.walkInCustomer;
            return HomeRecentBillModel.fromJson(billMap, customerName);
          }).toList();

          return HomeDashboardModel.fromJson(
            data,
            shopName: shopName,
            topProducts: topProducts,
            recentBills: recentBills,
          );
        });

    return result;
  }
}
