// lib/src/new_bill/view/widget/amount_entry_view.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vyapapp/res/styles/color_palette.dart';
import 'package:vyapapp/res/styles/font_palette.dart';
import 'package:vyapapp/utils/common_widgets/common_text_form_field.dart';
import 'package:vyapapp/utils/common_widgets/primary_button.dart';
import 'package:vyapapp/utils/helpers/extensions.dart';
import '../../model/new_bill_model.dart';

class AmountEntryView extends StatelessWidget {
  const AmountEntryView({
    super.key,
    required this.amountController,
    required this.descriptionController,
    required this.cartItems,
    required this.onAddPressed,
    required this.onRemoveItem,
  });

  final TextEditingController amountController;
  final TextEditingController descriptionController;
  final List<CartItemModel> cartItems;
  final VoidCallback onAddPressed;
  final ValueChanged<CartItemModel> onRemoveItem;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final manualItems = cartItems.where((item) => item.isCustom).toList();

    return Expanded(
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Amount Field
                  CommonTextFormField(
                    title: 'Amount (₹)',
                    hintText: 'Enter amount',
                    controller: amountController,
                    inputType: const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
                    ],
                  ),
                  16.verticalSpace,

                  // Description Field
                  CommonTextFormField(
                    title: 'Description',
                    hintText: 'e.g. Water Can, Delivery Fee',
                    controller: descriptionController,
                    textCapitalization: TextCapitalization.sentences,
                  ),
                  20.verticalSpace,

                  // Add button
                  PrimaryButton(
                    text: 'Add to Bill',
                    radius: 12,
                    onPressed: onAddPressed,
                  ),
                  24.verticalSpace,

                  // Added entries header
                  if (manualItems.isNotEmpty) ...[
                    Text(
                      'Added Entries',
                      style: FontPalette.base700(14, color: colors.primaryText),
                    ),
                    12.verticalSpace,
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: manualItems.length,
                      separatorBuilder: (_, __) => Divider(
                        color: colors.inputBorder,
                        height: 1.h,
                      ),
                      itemBuilder: (context, index) {
                        final item = manualItems[index];
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          child: Row(
                            children: [
                              // Icon badge
                              Container(
                                width: 32.r,
                                height: 32.r,
                                decoration: const BoxDecoration(
                                  color: ColorPalette.homeStatOrangeBg,
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Text(
                                    item.emoji,
                                    style: TextStyle(fontSize: 14.sp),
                                  ),
                                ),
                              ),
                              12.horizontalSpace,

                              // Label
                              Expanded(
                                child: Text(
                                  item.name,
                                  style: FontPalette.base600(
                                    14,
                                    color: colors.primaryText,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),

                              // Price
                              Text(
                                item.lineTotal.toCurrency(),
                                style: FontPalette.base700(
                                  14,
                                  color: colors.primaryText,
                                ),
                              ),
                              12.horizontalSpace,

                              // Delete Button
                              IconButton(
                                onPressed: () => onRemoveItem(item),
                                icon: Icon(
                                  Icons.delete_outline_rounded,
                                  size: 18.r,
                                  color: colors.errorText,
                                ),
                                constraints: const BoxConstraints(),
                                padding: EdgeInsets.zero,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
