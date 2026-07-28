// lib/src/home/view/widget/home_section_list_card.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thuga/res/styles/color_palette.dart';
import 'package:thuga/utils/common_widgets/common_container.dart';

class HomeSectionListCard extends StatelessWidget {
  const HomeSectionListCard({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return CommonContainer(
      padding: EdgeInsets.zero,
      borderRadius: 16.r,
      border: Border.all(color: colors.inputBorder, width: 1.h),
      boxShadow: const [],
      child: Column(
        children: [
          for (var i = 0; i < children.length; i++) ...[
            children[i],
            if (i < children.length - 1)
              Divider(
                height: 1.h,
                thickness: 1.h,
                color: colors.inputBorder,
                indent: 16.w,
                endIndent: 16.w,
              ),
          ],
        ],
      ),
    );
  }
}
