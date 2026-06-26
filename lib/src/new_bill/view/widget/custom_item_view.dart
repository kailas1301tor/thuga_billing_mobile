// lib/src/new_bill/view/widget/custom_item_view.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vyapapp/res/styles/color_palette.dart';
import 'package:vyapapp/res/styles/font_palette.dart';
import 'package:vyapapp/utils/common_widgets/common_text_form_field.dart';
import 'package:vyapapp/utils/common_widgets/primary_button.dart';

class CustomItemView extends StatelessWidget {
  const CustomItemView({
    super.key,
    required this.nameController,
    required this.qtyController,
    required this.priceController,
    required this.onAddPressed,
  });

  final TextEditingController nameController;
  final TextEditingController qtyController;
  final TextEditingController priceController;
  final VoidCallback onAddPressed;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Item Name Field
          CommonTextFormField(
            title: 'Item Name',
            hintText: 'e.g. Special Juice, Bakery Box',
            controller: nameController,
            textCapitalization: TextCapitalization.words,
          ),
          16.verticalSpace,

          // Quantity Field
          CommonTextFormField(
            title: 'Quantity',
            hintText: 'e.g. 2',
            controller: qtyController,
            inputType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
          ),
          16.verticalSpace,

          // Price Field
          CommonTextFormField(
            title: 'Unit Price (₹)',
            hintText: 'e.g. 35.00',
            controller: priceController,
            inputType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
            ],
          ),
          16.verticalSpace,

          // Live Auto-calculated Total Container
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: colors.inputBackground,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: colors.inputBorder, width: 1.w),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Estimated Total',
                  style: FontPalette.base500(13, color: colors.secondaryText),
                ),
                ListenableBuilder(
                  listenable: Listenable.merge([qtyController, priceController]),
                  builder: (context, _) {
                    final qty = int.tryParse(qtyController.text) ?? 0;
                    final price = double.tryParse(priceController.text) ?? 0.0;
                    final total = qty * price;
                    return Text(
                      '₹${total.toStringAsFixed(2)}',
                      style: FontPalette.base700(16, color: colors.primary),
                    );
                  },
                ),
              ],
            ),
          ),
          24.verticalSpace,

          // Add Item button
          PrimaryButton(
            text: 'Add Item',
            radius: 12,
            onPressed: onAddPressed,
          ),
        ],
      ),
    );
  }
}
