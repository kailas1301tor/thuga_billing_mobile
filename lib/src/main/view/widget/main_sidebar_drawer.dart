// lib/src/main/view/widget/main_sidebar_drawer.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vyapapp/res/constants/string_constants.dart';
import 'package:vyapapp/res/styles/color_palette.dart';
import 'package:vyapapp/res/styles/font_palette.dart';
import 'package:vyapapp/src/categories/view/category_crud_screen.dart';
import 'package:vyapapp/src/products/view/product_crud_screen.dart';
import 'package:vyapapp/src/customers/view/customer_crud_screen.dart';
import 'package:vyapapp/src/purchase/view/purchases_screen.dart';
import 'package:vyapapp/src/calculation/view/calculation_screen.dart';

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
                  Container(
                    width: 48.r,
                    height: 48.r,
                    decoration: BoxDecoration(
                      color: colors.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                    child: Icon(
                      Icons.storefront_rounded,
                      color: colors.primary,
                      size: 24.r,
                    ),
                  ),
                  16.horizontalSpace,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Thuka Menu',
                          style: FontPalette.base700(
                            16,
                            color: colors.primaryText,
                          ),
                        ),
                        Text(
                          'Manage business inventory',
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
