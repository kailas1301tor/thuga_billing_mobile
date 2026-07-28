// lib/src/calculation/view/calculation_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thuga/res/constants/string_constants.dart';
import 'package:thuga/res/styles/color_palette.dart';
import 'package:thuga/utils/common_widgets/common_app_bar.dart';
import 'package:thuga/utils/common_widgets/common_dialog_box.dart';
import 'package:thuga/utils/common_widgets/common_empty_state.dart';
import 'package:thuga/utils/common_widgets/common_scaffold.dart';
import 'package:thuga/utils/common_widgets/common_switch_state.dart';
import 'package:thuga/utils/common_widgets/web/responsive_list_grid.dart';

import '../notifier/calculation_list_notifier.dart';
import 'calculation_detail_screen.dart';
import 'calculation_editor_screen.dart';
import 'widget/calculation_bill_card.dart';

class CalculationScreen extends ConsumerWidget {
  const CalculationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.appColors;
    final loaderState = ref.watch(
      calculationListProvider.select((s) => s.loaderState),
    );
    final bills = ref.watch(
      calculationListProvider.select((s) => s.bills),
    );
    final notifier = ref.read(calculationListProvider.notifier);

    return CommonScaffold(
      backgroundColor: colors.background,
      appBar: CommonAppBar(
        title: Strings.calculationTitle,
        showBackButton: true,
        actions: [
          IconButton(
            icon: Icon(Icons.add_rounded, size: 24.r, color: colors.primaryText),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const CalculationEditorScreen(),
                ),
              ).then((_) => notifier.refresh());
            },
          ),
        ],
      ),
      body: CommonSwitchState(
        loaderState: loaderState,
        reload: () => notifier.refresh(),
        buttonText: Strings.refresh,
        child: bills.isEmpty
            ? CommonEmptyState(
                title: Strings.noCalculationBills,
                message: Strings.noCalculationBillsHint,
                buttonText: Strings.newCalculationBill,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const CalculationEditorScreen(),
                    ),
                  ).then((_) => notifier.refresh());
                },
              )
            : ResponsiveListGrid(
                padding: EdgeInsets.all(20.w),
                itemCount: bills.length,
                minItemWidth: 320,
                itemBuilder: (context, index) {
                  final summary = bills[index];
                  return CalculationBillCard(
                    summary: summary,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CalculationDetailScreen(
                            billId: summary.bill.id,
                          ),
                        ),
                      ).then((_) => notifier.refresh());
                    },
                    onDelete: () {
                      CommonDialogBox.show(
                        context: context,
                        title: Strings.delete,
                        message: Strings.deleteBillConfirm,
                        primaryLabel: Strings.delete,
                        secondaryLabel: Strings.cancel,
                        onPrimary: () =>
                            notifier.deleteBill(summary.bill.id),
                      );
                    },
                  );
                },
              ),
      ),
    );
  }
}
