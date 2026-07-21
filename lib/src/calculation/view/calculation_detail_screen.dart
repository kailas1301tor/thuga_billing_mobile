// lib/src/calculation/view/calculation_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vyapapp/res/constants/string_constants.dart';
import 'package:vyapapp/res/styles/color_palette.dart';
import 'package:vyapapp/res/styles/font_palette.dart';
import 'package:vyapapp/utils/common_widgets/common_app_bar.dart';
import 'package:vyapapp/utils/common_widgets/common_container.dart';
import 'package:vyapapp/utils/common_widgets/common_nav_bar_button.dart';
import 'package:vyapapp/utils/common_widgets/common_scaffold.dart';
import 'package:vyapapp/utils/common_widgets/common_switch_state.dart';
import 'package:vyapapp/utils/helpers/calculation_total_helper.dart';
import 'package:vyapapp/utils/helpers/extensions.dart';

import '../notifier/calculation_detail_notifier.dart';
import 'calculation_editor_screen.dart';
import 'widget/calculation_detail_customer_block.dart';

class CalculationDetailScreen extends ConsumerWidget {
  const CalculationDetailScreen({super.key, required this.billId});

  final String billId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.appColors;
    final state = ref.watch(calculationDetailNotifierProvider(billId));
    final notifier = ref.read(calculationDetailNotifierProvider(billId).notifier);
    final bill = state.bill;
    final prices = buildCalculationPriceMap(state.categories);

    return CommonScaffold(
      backgroundColor: colors.background,
      appBar: CommonAppBar(
        title: Strings.calculationBillDetails,
        showBackButton: true,
        actions: [
          if (bill != null)
            CommonNavBarButton(
              icon: Icon(Icons.edit_outlined, size: 22.r, color: colors.primaryText),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        CalculationEditorScreen(billId: bill.id),
                  ),
                ).then((_) => notifier.refresh());
              },
            ),
        ],
      ),
      body: CommonSwitchState(
        loaderState: state.loaderState,
        reload: () => notifier.refresh(),
        buttonText: Strings.refresh,
        child: bill == null
            ? const SizedBox.shrink()
            : Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.all(20.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            bill.name,
                            style: FontPalette.base700(
                              22,
                              color: colors.primaryText,
                            ),
                          ),
                          4.verticalSpace,
                          Text(
                            'Updated ${bill.updatedAt.day}/${bill.updatedAt.month}/${bill.updatedAt.year}',
                            style: FontPalette.base400(
                              12,
                              color: colors.secondaryText,
                            ),
                          ),
                          16.verticalSpace,
                          ...bill.customerSections.map(
                            (section) => CalculationDetailCustomerBlock(
                              section: section,
                              prices: prices,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  CommonContainer(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 16.h,
                    ),
                    borderRadius: 0,
                    color: colors.surface,
                    border: Border(
                      top: BorderSide(color: colors.inputBorder, width: 1.w),
                    ),
                    child: SafeArea(
                      top: false,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            Strings.grandTotal,
                            style: FontPalette.base700(
                              16,
                              color: colors.primaryText,
                            ),
                          ),
                          Text(
                            state.grandTotal.toCurrency(),
                            style: FontPalette.base700(
                              20,
                              color: colors.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
