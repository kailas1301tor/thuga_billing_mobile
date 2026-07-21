// lib/utils/helpers/calculation_total_helper.dart
import 'package:vyapapp/src/calculation/model/calculation_bill_model.dart';
import 'package:vyapapp/src/calculation/model/calculation_catalog_model.dart';

Map<int, double> buildCalculationPriceMap(
  List<CalculationCategoryModel> categories,
) {
  final prices = <int, double>{};
  for (final category in categories) {
    for (final product in category.products) {
      prices[product.id] = product.price;
    }
  }
  return prices;
}

double calculationSectionTotal(
  CalculationCustomerSectionModel section,
  Map<int, double> prices,
) =>
    section.items.fold<double>(
      0,
      (sum, item) => sum + item.quantity * (prices[item.productId] ?? 0),
    );

double calculationBillGrandTotal(
  CalculationBillModel bill,
  Map<int, double> prices,
) =>
    bill.customerSections.fold<double>(
      0,
      (sum, section) => sum + calculationSectionTotal(section, prices),
    );

double calculationLineTotal(
  CalculationLineItemModel item,
  Map<int, double> prices,
) =>
    item.quantity * (prices[item.productId] ?? 0);

String generateCalculationBillId() =>
    'calc_${DateTime.now().microsecondsSinceEpoch}';
