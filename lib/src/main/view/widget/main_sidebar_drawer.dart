// lib/src/main/view/widget/main_sidebar_drawer.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:thuga/res/styles/color_palette.dart';
import 'package:thuga/src/main/view/widget/main_sidebar_menu_items.dart';

class MainSidebarDrawer extends StatelessWidget {
  const MainSidebarDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Drawer(
      backgroundColor: colors.surface,
      elevation: 16.r,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const MainSidebarHeader(),
            const Divider(height: 1),
            SizedBox(height: 12.h),
            for (final item in MainSidebarMenuItems.secondaryItems)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
                child: MainSidebarMenuTile(
                  item: item,
                  onTap: () {
                    Navigator.pop(context);
                    context.push(item.route);
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
