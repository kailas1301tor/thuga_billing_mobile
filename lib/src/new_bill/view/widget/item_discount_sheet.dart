// lib/src/new_bill/view/widget/item_discount_sheet.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thuga/res/enums/enums.dart';
import 'package:thuga/res/styles/color_palette.dart';
import 'package:thuga/res/styles/font_palette.dart';
import 'package:thuga/utils/common_widgets/common_text_form_field.dart';
import 'package:thuga/utils/common_widgets/common_loader.dart';
import 'package:thuga/utils/common_widgets/primary_button.dart';
import 'package:thuga/utils/helpers/extensions.dart';
import 'package:thuga/utils/helpers/toast_helper.dart';
import 'package:thuga/utils/common_widgets/common_cached_network_image.dart';
import 'package:thuga/utils/helpers/unit_conversion_helper.dart';
import '../../../main/notifier/dropdowns_notifier.dart';
import '../../model/new_bill_model.dart';

class ItemDiscountSheet extends ConsumerStatefulWidget {
  const ItemDiscountSheet({
    super.key,
    required this.item,
    required this.onApply,
    required this.onRemove,
  });

  final CartItemModel item;
  final void Function({
    required String discountType,
    required double discountValue,
    int? bogoBuyQty,
    int? bogoGetQty,
  }) onApply;
  final VoidCallback onRemove;

  @override
  ConsumerState<ItemDiscountSheet> createState() => _ItemDiscountSheetState();
}

class _ItemDiscountSheetState extends ConsumerState<ItemDiscountSheet> {
  late String _selectedType;
  late final TextEditingController _valueController;
  late final TextEditingController _buyQtyController;
  late final TextEditingController _getQtyController;

  @override
  void initState() {
    super.initState();
    _selectedType = widget.item.discountType;
    _valueController = TextEditingController(
      text: widget.item.discountValue > 0
          ? widget.item.discountValue.toStringAsFixed(2)
          : '',
    );
    _buyQtyController = TextEditingController(
      text: widget.item.bogoBuyQty?.toString() ?? '1',
    );
    _getQtyController = TextEditingController(
      text: widget.item.bogoGetQty?.toString() ?? '1',
    );
  }

  @override
  void dispose() {
    _valueController.dispose();
    _buyQtyController.dispose();
    _getQtyController.dispose();
    super.dispose();
  }

  bool _validate() {
    final value = double.tryParse(_valueController.text) ?? 0.0;
    final rawTotal = widget.item.lineTotal;

    switch (_selectedType) {
      case 'None':
        return true;
      case 'Percentage':
        if (value <= 0 || value > 100) {
          showCustomErrorToast(message: 'Percentage must be between 1 and 100');
          return false;
        }
        return true;
      case 'Amount':
        if (value <= 0 || value > rawTotal) {
          showCustomErrorToast(
            message:
                'Amount must be between ${1.toCurrency()} and ${rawTotal.toCurrency()}',
          );
          return false;
        }
        return true;
      case 'Slab':
        if (value <= 0 || value >= widget.item.price) {
          showCustomErrorToast(
            message:
                'Slab price must be less than ${widget.item.price.toCurrency()}',
          );
          return false;
        }
        return true;
      case 'BOGO':
        final buyQty = int.tryParse(_buyQtyController.text) ?? 0;
        final getQty = int.tryParse(_getQtyController.text) ?? 0;
        if (buyQty <= 0 || getQty <= 0) {
          showCustomErrorToast(
            message: 'Buy and Get quantities must be at least 1',
          );
          return false;
        }
        return true;
      default:
        return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final dropdownsState = ref.watch(dropdownsProvider);
    final discountTypes = dropdownsState.data.discountTypes;
    final isDropdownsLoading =
        dropdownsState.loaderState == LoaderState.loading &&
        discountTypes.isEmpty;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Item Summary Header
          _buildItemHeader(colors),
          16.verticalSpace,

          // Discount Type Chips
          Text(
            'Discount Type',
            style: FontPalette.base600(13, color: colors.secondaryText),
          ),
          10.verticalSpace,
          if (isDropdownsLoading)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 24.h),
              child: const Center(child: CommonLoader()),
            )
          else if (discountTypes.isEmpty)
            Text(
              'Discount types unavailable. Pull to refresh and try again.',
              style: FontPalette.base400(13, color: colors.secondaryText),
            )
          else
            Wrap(
              spacing: 8.w,
              runSpacing: 8.h,
              children: discountTypes.map((type) {
              final isSelected = _selectedType == type.id;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedType = type.id;
                    // Reset controllers when switching type
                    if (type.id != widget.item.discountType) {
                      _valueController.clear();
                      _buyQtyController.text = '1';
                      _getQtyController.text = '1';
                    }
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? colors.primary.withValues(alpha: 0.12)
                        : colors.inputBackground,
                    borderRadius: BorderRadius.circular(100.r),
                    border: Border.all(
                      color: isSelected
                          ? colors.primary
                          : colors.inputBorder,
                      width: 1.w,
                    ),
                  ),
                  child: Text(
                    type.name,
                    style: FontPalette.base600(
                      13,
                      color: isSelected ? colors.primary : colors.primaryText,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          20.verticalSpace,

          // Dynamic Input Fields based on discount type
          _buildDynamicInputs(colors),
          24.verticalSpace,

          // Action Buttons
          Row(
            children: [
              if (widget.item.hasDiscount) ...[
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      widget.onRemove();
                      Navigator.pop(context);
                      showCustomToast(message: 'Discount removed');
                    },
                    child: Text(
                      'Remove',
                      style:
                          FontPalette.base600(14, color: Colors.red.shade600),
                    ),
                  ),
                ),
                12.horizontalSpace,
              ],
              Expanded(
                flex: 2,
                child: PrimaryButton(
                  text: 'Apply Discount',
                  radius: 12,
                  onPressed: _selectedType == 'None'
                      ? () {
                          widget.onRemove();
                          Navigator.pop(context);
                        }
                      : () {
                          if (!_validate()) return;

                          final value =
                              double.tryParse(_valueController.text) ?? 0.0;
                          final buyQty =
                              int.tryParse(_buyQtyController.text);
                          final getQty =
                              int.tryParse(_getQtyController.text);

                          widget.onApply(
                            discountType: _selectedType,
                            discountValue: value,
                            bogoBuyQty:
                                _selectedType == 'BOGO' ? buyQty : null,
                            bogoGetQty:
                                _selectedType == 'BOGO' ? getQty : null,
                          );
                          Navigator.pop(context);
                          showCustomToast(message: 'Discount applied');
                        },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildItemHeader(AppColors colors) {
    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: colors.inputBackground,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: colors.inputBorder, width: 1.w),
      ),
      child: Row(
        children: [
          Container(
            width: 40.r,
            height: 40.r,
            decoration: BoxDecoration(
              color: colors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10.r),
            ),
            clipBehavior: Clip.antiAlias,
            child: (widget.item.imageUrl != null && widget.item.imageUrl!.isNotEmpty)
                ? CommonCachedNetworkImage(
                    imageUrl: widget.item.imageUrl!,
                    width: 40.r,
                    height: 40.r,
                    memCacheWidth: 80,
                    memCacheHeight: 80,
                    fit: BoxFit.cover,
                  )
                : Center(
                    child: Text(
                      widget.item.emoji,
                      style: TextStyle(fontSize: 20.sp),
                    ),
                  ),
          ),
          12.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.item.name,
                  style: FontPalette.base700(14, color: colors.primaryText),
                ),
                4.verticalSpace,
                Text(
                  '${widget.item.price.toCurrency()} × ${formatQuantityWithUnit(quantity: widget.item.quantity, unitId: widget.item.billingUnit)} = ${widget.item.lineTotal.toCurrency()}',
                  style: FontPalette.base400(12, color: colors.secondaryText),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDynamicInputs(AppColors colors) {
    switch (_selectedType) {
      case 'Percentage':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonTextFormField(
              controller: _valueController,
              title: 'Discount Percentage (%)',
              hintText: 'e.g. 10',
              inputType:
                  const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                  RegExp(r'^\d*\.?\d{0,2}'),
                ),
              ],
              autoFocus: true,
            ),
            8.verticalSpace,
            _buildPreviewText(colors),
          ],
        );
      case 'Amount':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonTextFormField(
              controller: _valueController,
              title: 'Discount Amount (₹)',
              hintText: 'e.g. 50',
              inputType:
                  const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                  RegExp(r'^\d*\.?\d{0,2}'),
                ),
              ],
              autoFocus: true,
            ),
            8.verticalSpace,
            _buildPreviewText(colors),
          ],
        );
      case 'Slab':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonTextFormField(
              controller: _valueController,
              title: 'Slab Unit Price (₹)',
              hintText:
                  'e.g. 80 (original: ${widget.item.price.toCurrency()})',
              inputType:
                  const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                  RegExp(r'^\d*\.?\d{0,2}'),
                ),
              ],
              autoFocus: true,
            ),
            8.verticalSpace,
            _buildPreviewText(colors),
          ],
        );
      case 'BOGO':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: CommonTextFormField(
                    controller: _buyQtyController,
                    title: 'Buy Qty',
                    hintText: 'e.g. 1',
                    inputType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    autoFocus: true,
                  ),
                ),
                12.horizontalSpace,
                Expanded(
                  child: CommonTextFormField(
                    controller: _getQtyController,
                    title: 'Get Qty (Free)',
                    hintText: 'e.g. 1',
                    inputType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                  ),
                ),
              ],
            ),
            8.verticalSpace,
            _buildPreviewText(colors),
          ],
        );
      default:
        // 'None' — no inputs needed
        return Text(
          'No discount will be applied.',
          style: FontPalette.base400(13, color: colors.secondaryText),
        );
    }
  }

  Widget _buildPreviewText(AppColors colors) {
    final value = double.tryParse(_valueController.text) ?? 0.0;
    final buyQty = int.tryParse(_buyQtyController.text) ?? 0;
    final getQty = int.tryParse(_getQtyController.text) ?? 0;

    // Build a temporary item to compute preview
    final preview = widget.item.copyWith(
      discountType: _selectedType,
      discountValue: value,
      bogoBuyQty: () => _selectedType == 'BOGO' ? buyQty : null,
      bogoGetQty: () => _selectedType == 'BOGO' ? getQty : null,
    );

    if (preview.discountAmount <= 0) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        children: [
          Icon(Icons.savings_outlined, size: 16.r, color: Colors.green.shade700),
          8.horizontalSpace,
          Expanded(
            child: Text(
              'You save ${preview.discountAmount.toCurrency()} · Final: ${preview.totalPrice.toCurrency()}',
              style: FontPalette.base600(12, color: Colors.green.shade700),
            ),
          ),
        ],
      ),
    );
  }
}
