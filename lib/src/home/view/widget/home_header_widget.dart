// lib/src/home/view/widget/home_header_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thuga/res/constants/string_constants.dart';
import 'package:thuga/res/styles/color_palette.dart';
import 'package:thuga/res/styles/font_palette.dart';
import 'package:thuga/utils/common_widgets/common_container.dart';

class HomeHeaderWidget extends StatelessWidget {
  const HomeHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 0),
      child: Row(
        children: [
          Semantics(
            label: Strings.homeMenu,
            child: CommonContainer(
              width: 40.r,
              height: 40.r,
              padding: EdgeInsets.zero,
              borderRadius: 14.r,
              color: colors.inputBackground,
              boxShadow: const [],
              onTap: () => context.findRootAncestorStateOfType<ScaffoldState>()?.openDrawer(),
              child: Center(
                child: Icon(
                  Icons.menu_rounded,
                  size: 24.r,
                  color: colors.primaryText,
                ),
              ),
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  Strings.appName,
                  style: FontPalette.base700(20, color: colors.primary),
                ),
                4.horizontalSpace,
                Icon(
                  Icons.auto_awesome,
                  size: 14.r,
                  color: colors.primary,
                ),
              ],
            ),
          ),
          SizedBox(width: 40.r),
        ],
      ),
    );
  }
}
