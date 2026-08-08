// lib/src/main/view/widget/main_sidebar_drawer.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thuga/res/constants/assets.dart';
import 'package:thuga/res/constants/string_constants.dart';
import 'package:thuga/res/styles/color_palette.dart';
import 'package:thuga/res/styles/font_palette.dart';
import 'package:thuga/src/categories/view/category_crud_screen.dart';
import 'package:thuga/src/products/view/product_crud_screen.dart';
import 'package:thuga/src/customers/view/customer_crud_screen.dart';
import 'package:thuga/src/purchase/view/purchases_screen.dart';
import 'package:thuga/src/calculation/view/calculation_screen.dart';

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
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(14.r),
                    child: Image.asset(
                      Assets.appIcon,
                      width: 48.r,
                      height: 48.r,
                      fit: BoxFit.cover,
                    ),
                  ),
                  16.horizontalSpace,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          Strings.appMenuTitle,
                          style: FontPalette.base700(
                            16,
                            color: colors.primaryText,
                          ),
                        ),
                        Text(
                          Strings.appMenuSubtitle,
                          style: FontPalette.base400(
                            11,
                            color: colors.secondaryText,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            12.verticalSpace,
            _buildMenuItem(
              context: context,
              icon: Icons.grid_view_rounded,
              title: 'Categories',
              subtitle: 'Manage product divisions',
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CategoryCrudScreen()),
                );
              },
            ),
            _buildMenuItem(
              context: context,
              icon: Icons.inventory_2_rounded,
              title: 'Products',
              subtitle: 'Stock lists & pricing',
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ProductCrudScreen()),
                );
              },
            ),
            _buildMenuItem(
              context: context,
              icon: Icons.people_alt_rounded,
              title: 'Customers',
              subtitle: 'Store contacts directory',
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CustomerCrudScreen()),
                );
              },
            ),
            _buildMenuItem(
              context: context,
              icon: Icons.calculate_rounded,
              title: Strings.calculationTitle,
              subtitle: Strings.calculationSubtitle,
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const CalculationScreen(),
                  ),
                );
              },
            ),
            _buildMenuItem(
              context: context,
              icon: Icons.shopping_bag_rounded,
              title: 'Purchases',
              subtitle: 'Stock procurement & bills',
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const PurchasesScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    final colors = context.appColors;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        leading: Icon(icon, color: colors.secondaryText, size: 22.r),
        title: Text(
          title,
          style: FontPalette.base600(14, color: colors.primaryText),
        ),
        subtitle: Text(
          subtitle,
          style: FontPalette.base400(11, color: colors.secondaryText),
        ),
        trailing: Icon(
          Icons.chevron_right_rounded,
          color: colors.secondaryText,
          size: 20.r,
        ),
        onTap: onTap,
        hoverColor: colors.inputBackground,
      ),
    );
  }
}
