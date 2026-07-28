// /Users/wac/Documents/wac projects/tsuite/lib/utils/common_widgets/common_search_bar.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:thuga/res/constants/assets.dart';
import 'package:thuga/res/constants/string_constants.dart';
import 'package:thuga/res/styles/color_palette.dart';
import 'package:thuga/utils/common_widgets/common_text_form_field.dart';

class CommonSearchBar extends StatelessWidget {
  const CommonSearchBar({
    super.key,
    required this.controller,
    this.hintText,
    this.onChanged,
    this.onSubmitted,
    this.onClear,
    this.focusNode,
    this.dense = false,
  });

  final TextEditingController controller;
  final String? hintText;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onClear;
  final FocusNode? focusNode;
  final bool dense;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: controller,
      builder: (context, value, _) {
        final hasText = value.text.trim().isNotEmpty;

        return CommonTextFormField(
          controller: controller,
          focusNode: focusNode,
          hintText: hintText ?? Strings.search,
          onChanged: onChanged,
          onSubmitted: onSubmitted,
          inputAction: TextInputAction.search,
          height: dense ? 40.h : 48.h,
          borderRadius: 24, // Search bar should be pill-shaped
          contentPadding: dense
              ? EdgeInsets.symmetric(horizontal: 12.w)
              : EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          suffix: hasText
              ? IconButton(
                  tooltip: Strings.clear,
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(
                    minWidth: dense ? 36.w : 48.w,
                    minHeight: dense ? 36.h : 48.h,
                  ),
                  onPressed: () {
                    controller.clear();
                    onChanged?.call('');
                    onClear?.call();
                  },
                  icon: SvgPicture.asset(
                    Assets.svgCloseIcon,
                    width: dense ? 14.r : 18.r,
                    height: dense ? 14.r : 18.r,
                    colorFilter: ColorFilter.mode(
                      context.appColors.secondaryText,
                      BlendMode.srcIn,
                    ),
                  ),
                )
              : null,
          prefixIcon: Padding(
            padding: EdgeInsets.only(left: dense ? 12.w : 14.w, right: dense ? 6.w : 8.w),
            child: SvgPicture.asset(
              Assets.svgSearch,
              width: dense ? 16.r : 18.r,
              height: dense ? 16.r : 18.r,
              colorFilter: ColorFilter.mode(
                context.appColors.secondaryText,
                BlendMode.srcIn,
              ),
            ),
          ),
          prefixIconConstraints: BoxConstraints(
            minWidth: dense ? 34.w : 48.w,
            minHeight: dense ? 16.r : 18.r,
          ),
          onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
        );
      },
    );
  }
}
