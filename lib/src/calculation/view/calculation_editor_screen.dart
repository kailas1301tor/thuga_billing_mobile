// lib/src/calculation/view/calculation_editor_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tuple/tuple.dart';
import 'package:thuga/res/constants/string_constants.dart';
import 'package:thuga/res/enums/enums.dart';
import 'package:thuga/res/styles/color_palette.dart';
import 'package:thuga/res/styles/font_palette.dart';
import 'package:thuga/src/main/model/dropdown_model.dart';
import 'package:thuga/src/main/notifier/dropdowns_notifier.dart';
import 'package:thuga/utils/common_widgets/bottomsheet_content.dart';
import 'package:thuga/utils/common_widgets/common_app_bar.dart';
import 'package:thuga/utils/common_widgets/common_dialog_box.dart';
import 'package:thuga/utils/common_widgets/common_loader.dart';
import 'package:thuga/utils/common_widgets/common_scaffold.dart';
import 'package:thuga/utils/common_widgets/common_text_form_field.dart';
import 'package:thuga/utils/common_widgets/primary_button.dart';
import 'package:thuga/utils/helpers/calculation_total_helper.dart';
import 'package:thuga/utils/helpers/extensions.dart';

import '../notifier/calculation_editor_notifier.dart';
import 'calculation_detail_screen.dart';
import 'widget/calculation_category_chips.dart';
import 'widget/calculation_customer_section_card.dart';
import 'widget/calculation_line_item_row.dart';
import 'widget/calculation_product_tile.dart';

class CalculationEditorScreen extends ConsumerWidget {
  const CalculationEditorScreen({super.key, this.billId});

  final String? billId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.appColors;
    final provider = calculationEditorProvider(billId);
    final notifier = ref.read(provider.notifier);
    final isEditing = billId != null && billId!.isNotEmpty;

    final editorData = ref.watch(
      provider.select(
        (s) => Tuple5(
          s.customerSections,
          s.activeCustomerId,
          s.categories,
          s.products,
          s.selectedCategoryId,
        ),
      ),
    );
    final catalogLoader = ref.watch(
      provider.select((s) => s.catalogLoaderState),
    );
    final isSaving = ref.watch(provider.select((s) => s.isSaving));
    final grandTotal = ref.watch(
      provider.select((s) {
        final prices = buildCalculationPriceMap(s.categories);
        return s.customerSections.fold<double>(
          0,
          (sum, section) => sum + calculationSectionTotal(section, prices),
        );
      }),
    );

    final sections = editorData.item1;
    final activeCustomerId = editorData.item2;
    final categories = editorData.item3;
    final products = editorData.item4;

    final customers = ref.watch(
      dropdownsProvider.select((s) => s.data.customers),
    );
    final customersLoader = ref.watch(
      dropdownsProvider.select((s) => s.loaderState),
    );

    final addedIds = sections.map((s) => s.customerId).toSet();
    final availableCustomers = customers
        .where((c) => !addedIds.contains(c.id))
        .toList();

    return CommonScaffold(
      backgroundColor: colors.background,
      appBar: CommonAppBar(
        title: isEditing
            ? Strings.editCalculationBill
            : Strings.newCalculationBill,
        showBackButton: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 12.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CommonTextFormField(
                    controller: notifier.billNameController,
                    title: Strings.billName,
                    hintText: Strings.billNameHint,
                    onChanged: notifier.onBillNameChanged,
                  ),
                  16.verticalSpace,
                  OutlinedButton.icon(
                    onPressed: availableCustomers.isEmpty
                        ? null
                        : () {
                            showSingleSelectBottomSheet<DropdownCustomerModel>(
                              context: context,
                              ref: ref,
                              title: Strings.addCustomerToBill,
                              options: availableCustomers,
                              currentValue: null,
                              loaderState: customersLoader,
                              displayText: (c) => c.name,
                              onSelected: notifier.addCustomerSection,
                            );
                          },
                    icon: Icon(Icons.person_add_alt_1_rounded, size: 18.r),
                    label: Text(Strings.addCustomerToBill),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: colors.primary,
                      side: BorderSide(color: colors.primary, width: 1.w),
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                  ),
                  16.verticalSpace,
                  ...sections.map((section) {
                    final prices = buildCalculationPriceMap(categories);
                    final subtotal = calculationSectionTotal(section, prices);
                    final isExpanded = activeCustomerId == section.customerId;

                    return CalculationCustomerSectionCard(
                      section: section,
                      isExpanded: isExpanded,
                      subtotal: subtotal,
                      onTap: () =>
                          notifier.setActiveCustomer(section.customerId),
                      onRemove: () {
                        CommonDialogBox.show(
                          context: context,
                          title: Strings.delete,
                          message: Strings.removeCustomerConfirm,
                          primaryLabel: Strings.delete,
                          secondaryLabel: Strings.cancel,
                          onPrimary: () => notifier.removeCustomerSection(
                            section.customerId,
                          ),
                        );
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          if (section.items.isNotEmpty) ...[
                            ...section.items.map(
                              (item) => CalculationLineItemRow(
                                item: item,
                                lineTotal: calculationLineTotal(
                                  item,
                                  prices,
                                ),
                                onDecrement: () => notifier.updateQuantity(
                                  item.productId,
                                  item.quantity - 1,
                                ),
                                onIncrement: () => notifier.updateQuantity(
                                  item.productId,
                                  item.quantity + 1,
                                ),
                              ),
                            ),
                            12.verticalSpace,
                          ],
                          if (catalogLoader == LoaderState.loading)
                            const Padding(
                              padding: EdgeInsets.all(16),
                              child: CommonLoader(),
                            )
                          else if (isExpanded) ...[
                            if (categories.isNotEmpty)
                              CalculationCategoryChips(
                                categories: categories,
                                selectedCategoryId: editorData.item5,
                                onCategorySelected: notifier.setCategory,
                              ),
                            10.verticalSpace,
                            GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 8.w,
                                mainAxisSpacing: 8.h,
                                childAspectRatio: 0.72,
                              ),
                              itemCount: products.length,
                              itemBuilder: (context, index) {
                                final product = products[index];
                                final qty = notifier.productQuantityInActiveSection(
                                  product.id,
                                );
                                return CalculationProductTile(
                                  product: product,
                                  quantity: qty,
                                  onTap: () => notifier.addProduct(product),
                                  onReduce: () => notifier.updateQuantity(
                                    product.id,
                                    qty - 1,
                                  ),
                                );
                              },
                            ),
                          ],
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 20.h),
            decoration: BoxDecoration(
              color: colors.surface,
              border: Border(
                top: BorderSide(color: colors.inputBorder, width: 1.w),
              ),
            ),
            child: SafeArea(
              top: false,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        Strings.grandTotal,
                        style: FontPalette.base700(
                          15,
                          color: colors.primaryText,
                        ),
                      ),
                      Text(
                        grandTotal.toCurrency(),
                        style: FontPalette.base700(18, color: colors.primary),
                      ),
                    ],
                  ),
                  12.verticalSpace,
                  PrimaryButton(
                    text: Strings.saveBill,
                    isLoading: isSaving,
                    onPressed: () async {
                      final saved = await notifier.saveBill();
                      if (!context.mounted || !saved) return;
                      final savedId = ref.read(provider).billId;
                      if (savedId == null || savedId.isEmpty) {
                        Navigator.pop(context);
                        return;
                      }
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              CalculationDetailScreen(billId: savedId),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
