// lib/src/customers/view/widget/customer_card_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thuga/res/styles/color_palette.dart';
import 'package:thuga/res/styles/font_palette.dart';
import 'package:thuga/utils/common_widgets/common_container.dart';
import 'package:thuga/utils/common_widgets/common_nav_bar_button.dart';
import 'package:thuga/utils/common_widgets/common_cached_network_image.dart';
import 'package:thuga/src/customers/model/customer_model.dart';
import 'package:thuga/utils/helpers/date_formatter.dart';

class CustomerCardWidget extends StatelessWidget {
  const CustomerCardWidget({
    super.key,
    required this.customer,
    required this.onEdit,
    required this.onDelete,
  });

  final CustomerModel customer;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    final dateStr = customer.createdAt != null
        ? formatDate(customer.createdAt!)
        : 'Unknown Date';

    return CommonContainer(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      color: colors.surface,
      borderRadius: 16.r,
      border: Border.all(color: colors.inputBorder, width: 1.w),
      boxShadow: [
        BoxShadow(
          color: ColorPalette.black.withValues(alpha: 0.02),
          blurRadius: 8.r,
          offset: Offset(0, 4.h),
        ),
      ],
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 48.r,
            height: 48.r,
            decoration: BoxDecoration(
              color: colors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            clipBehavior: Clip.antiAlias,
            child: (customer.image != null && customer.image!.isNotEmpty)
                ? CommonCachedNetworkImage(
                    imageUrl: customer.image!,
                    width: 48.r,
                    height: 48.r,
                    memCacheWidth: 100,
                    memCacheHeight: 100,
                    fit: BoxFit.cover,
                  )
                : Center(
                    child: Icon(Icons.person_rounded, color: colors.primary, size: 24.r),
                  ),
          ),
          12.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        customer.name,
                        style: FontPalette.base600(15, color: colors.primaryText),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (customer.isActive)
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                        decoration: BoxDecoration(
                          color: ColorPalette.successColor.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        child: Text(
                          'Active',
                          style: FontPalette.base500(10, color: ColorPalette.successColor),
                        ),
                      )
                    else
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                        decoration: BoxDecoration(
                          color: colors.errorText.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        child: Text(
                          'Inactive',
                          style: FontPalette.base500(10, color: colors.errorText),
                        ),
                      )
                  ],
                ),
                4.verticalSpace,
                Text(
                  customer.phoneNumber,
                  style: FontPalette.base500(13, color: colors.primaryText),
                ),
                4.verticalSpace,
                Text(
                  'Created: $dateStr',
                  style: FontPalette.base400(12, color: colors.secondaryText),
                ),
              ],
            ),
          ),
          8.horizontalSpace,
          Column(
            children: [
              CommonNavBarButton(
                icon: Icon(Icons.edit_rounded, size: 18.r, color: colors.primary),
                onTap: onEdit,
              ),
              8.verticalSpace,
              CommonNavBarButton(
                icon: Icon(Icons.delete_rounded, size: 18.r, color: colors.errorText),
                onTap: onDelete,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
