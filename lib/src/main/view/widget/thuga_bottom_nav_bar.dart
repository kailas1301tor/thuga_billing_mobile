// lib/src/main/view/widget/thuga_bottom_nav_bar.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thuga/res/constants/string_constants.dart';
import 'package:thuga/res/styles/color_palette.dart';

import 'bottom_nav_item.dart';
import 'center_new_bill_button.dart';

class ThugaBottomNavBar extends StatelessWidget {
  const ThugaBottomNavBar({
    super.key,
    required this.selectedTab,
    required this.onTabSelected,
    required this.onNewBillPressed,
  });

  final int selectedTab;
  final ValueChanged<int> onTabSelected;
  final VoidCallback onNewBillPressed;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewPadding.bottom,
      ),

      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
        border: Border(
          top: BorderSide(color: colors.inputBorder, width: 1.h),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12.r,
            offset: Offset(0, -2.h),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          BottomNavItem(
            index: 0,
            selectedIndex: selectedTab,
            label: Strings.navHome,
            icon: Icons.home_outlined,
            onTap: () => onTabSelected(0),
          ),
          BottomNavItem(
            index: 1,
            selectedIndex: selectedTab,
            label: Strings.navBills,
            icon: Icons.receipt_long_outlined,
            onTap: () => onTabSelected(1),
          ),
          CenterNewBillButton(isSelected: false, onTap: onNewBillPressed),
          BottomNavItem(
            index: 2,
            selectedIndex: selectedTab,
            label: Strings.navReports,
            icon: Icons.bar_chart_outlined,
            onTap: () => onTabSelected(2),
          ),
          BottomNavItem(
            index: 3,
            selectedIndex: selectedTab,
            label: Strings.navSettings,
            icon: Icons.settings_outlined,
            onTap: () => onTabSelected(3),
          ),
        ],
      ),
    );
  }
}
