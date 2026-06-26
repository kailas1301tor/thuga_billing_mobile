import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../res/enums/enums.dart';
import '../../res/styles/color_palette.dart';
import '../../res/styles/font_palette.dart';

import 'primary_button.dart';

class BottomSheetContent extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;

  const BottomSheetContent({super.key, required this.child, this.padding});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOutBack,
      child: Container(
        width: double.infinity,
        padding:
            padding ?? EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: ColorPalette.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40.r),
            topRight: Radius.circular(40.r),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              alignment: Alignment.center,
              width: 35.w,
              height: 6.h,
              decoration: BoxDecoration(
                color: ColorPalette.fE7E7E7,
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            12.verticalSpace,
            child,
          ],
        ),
      ),
    );
  }
}

// Reusable Single Select Bottom Sheet with Generic Type T
void showSingleSelectBottomSheet<T>({
  required BuildContext context,
  required WidgetRef ref,
  required String title,
  required List<T> options,
  required T? currentValue,
  required Function(T) onSelected,
  required String Function(T) displayText,
  LoaderState loaderState = LoaderState.loaded,
  double?
  height, // If provided, bottom sheet will have fixed height with internal scrolling
}) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder:
        (_) => BottomSheetContent(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              BottomSheetHeader(
                title: title,
                onClose: () => Navigator.pop(context),
              ),
              20.verticalSpace,
              SafeArea(
                child:
                    loaderState == LoaderState.loading
                        ? Column(
                          children: List.generate(
                            3, // Show 3 placeholder items
                            (index) => Padding(
                              padding: EdgeInsets.symmetric(vertical: 8.h),
                              child: Row(
                                children: [
                                  Flexible(
                                    flex: 4,
                                    child:
                                        Container(
                                          height: 25.h,
                                          width: double.infinity,
                                          color: ColorPalette.white,
                                        ).showGradientShimmer(),
                                  ),
                                  Spacer(),
                                  Container(
                                    margin: EdgeInsets.all(4.h),
                                    height: 13.h,
                                    width: 13.h,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                  ).showGradientShimmer(),
                                ],
                              ),
                            ),
                          ),
                        )
                        : height != null
                        ? // Fixed height with internal scrolling
                        SizedBox(
                          height: height,
                          child: SingleChildScrollView(
                            child: SingleSelectOptionsList<T>(
                              options: options,
                              selectedOptionNotifier: ValueNotifier<T?>(
                                currentValue,
                              ),
                              onOptionSelected: (option) {
                                if (option == currentValue) {
                                  Navigator.pop(context);
                                  return;
                                }
                                Future.delayed(
                                  const Duration(milliseconds: 100),
                                  () {
                                    onSelected(option);
                                    if (context.mounted) {
                                      Navigator.pop(context);
                                    }
                                  },
                                );
                              },
                              displayText: displayText,
                            ),
                          ),
                        )
                        : // Dynamic height based on content
                        options.length >
                            8 // If more than 8 items, make it scrollable
                        ? SingleChildScrollView(
                          child: SingleSelectOptionsList<T>(
                            options: options,
                            selectedOptionNotifier: ValueNotifier<T?>(
                              currentValue,
                            ),
                            onOptionSelected: (option) {
                              if (option == currentValue) {
                                Navigator.pop(context);
                                return;
                              }
                              Future.delayed(
                                const Duration(milliseconds: 100),
                                () {
                                  onSelected(option);
                                  if (context.mounted) {
                                    Navigator.pop(context);
                                  }
                                },
                              );
                            },
                            displayText: displayText,
                          ),
                        )
                        : SingleSelectOptionsList<T>(
                          options: options,
                          selectedOptionNotifier: ValueNotifier<T?>(
                            currentValue,
                          ),
                          onOptionSelected: (option) {
                            if (option == currentValue) {
                              Navigator.pop(context);
                              return;
                            }
                            Future.delayed(
                              const Duration(milliseconds: 100),
                              () {
                                onSelected(option);
                                if (context.mounted) {
                                  Navigator.pop(context);
                                }
                              },
                            );
                          },
                          displayText: displayText,
                        ),
              ),
            ],
          ),
        ),
  );
}

// Generic Single Select Options List
class SingleSelectOptionsList<T> extends StatelessWidget {
  final List<T> options;
  final ValueNotifier<T?> selectedOptionNotifier;
  final Function(T) onOptionSelected;
  final String Function(T) displayText;

  const SingleSelectOptionsList({
    super.key,
    required this.options,
    required this.selectedOptionNotifier,
    required this.onOptionSelected,
    required this.displayText,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<T?>(
      valueListenable: selectedOptionNotifier,
      builder: (context, selectedOption, child) {
        return Column(
          children:
              options.map((option) {
                final isSelected = selectedOption == option;
                return Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (selectedOption == option) {
                          Navigator.pop(context);
                          return;
                        }

                        selectedOptionNotifier.value = option;
                        onOptionSelected(option);
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          color: ColorPalette.transparent,
                        ),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              displayText(option),
                              style: FontPalette.fBlack_16_500,
                            ),
                            Spacer(),
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              width: 21.w,
                              height: 21.h,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color:
                                      isSelected
                                          ? ColorPalette.secondaryColor
                                          : const Color(0xFFD1D1D1),
                                  width: 1,
                                ),
                              ),
                              child: Container(
                                margin: EdgeInsets.all(4.h),
                                height: 13.h,
                                width: 13.h,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color:
                                      isSelected
                                          ? ColorPalette.secondaryColor
                                          : Colors.transparent,
                                ),
                              ),
                            ),
                            5.horizontalSpace,
                          ],
                        ),
                      ),
                    ),
                    if (option != options.last)
                      const Divider(color: ColorPalette.fF1F1F1, height: 1),
                  ],
                );
              }).toList(),
        );
      },
    );
  }
}

// Reusable Multi Select Bottom Sheet with Generic Type T
void showMultiSelectBottomSheet<T>({
  required BuildContext context,
  required WidgetRef ref,
  required String title,
  required List<T> options,
  required List<T> selectedValues,
  Function(T)? onSelected,
  required String Function(T) displayText,
  required Function(List<T>) onValuesChanged,
}) {
  final selectedOptionsNotifier = ValueNotifier<List<T>>(
    List.from(selectedValues),
  );
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder:
        (_) => BottomSheetContent(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              BottomSheetHeader(
                title: title,
                onClose: () => Navigator.pop(context),
              ),
              20.verticalSpace,
              MultiSelectOptionsList<T>(
                options: options,
                selectedOptionsNotifier: selectedOptionsNotifier,
                onOptionSelected: (option) {
                  Future.delayed(const Duration(milliseconds: 400), () {
                    onSelected?.call(option);
                  });
                },
                displayText: displayText,
              ),
              20.verticalSpace,
              SafeArea(
                child: PrimaryButton(
                  onPressed: () {
                    onValuesChanged(selectedOptionsNotifier.value);
                    Navigator.pop(context);
                  },
                  text: "Save",
                  backgroundColor: ColorPalette.secondaryColor,
                  fontStyle: FontPalette.fWhite_16_600,
                ),
              ),
            ],
          ),
        ),
  ).then((_) => selectedOptionsNotifier.dispose());
}

// Generic Multi Select Options List
class MultiSelectOptionsList<T> extends StatelessWidget {
  final List<T> options;
  final ValueNotifier<List<T>> selectedOptionsNotifier;
  final Function(T) onOptionSelected;
  final String Function(T) displayText;

  const MultiSelectOptionsList({
    super.key,
    required this.options,
    required this.selectedOptionsNotifier,
    required this.onOptionSelected,
    required this.displayText,
  });

  void _toggleOption(T option) {
    final currentSelections = List<T>.from(selectedOptionsNotifier.value);

    // If "None" is selected, clear all other selections
    if (displayText(option) == "None") {
      selectedOptionsNotifier.value = [option];
    } else {
      // Remove "None" if any other option is selected
      currentSelections.removeWhere((item) => displayText(item) == "None");

      if (currentSelections.contains(option)) {
        currentSelections.remove(option);
        // If no options are selected, default to "None"
        if (currentSelections.isEmpty) {
          // Try to find the "None" option in the list
          final noneOption = options.firstWhere(
            (item) => displayText(item) == "None",
            orElse: () => option,
          );
          currentSelections.add(noneOption);
        }
      } else {
        currentSelections.add(option);
      }

      selectedOptionsNotifier.value = currentSelections;
    }
    onOptionSelected(option);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<T>>(
      valueListenable: selectedOptionsNotifier,
      builder: (context, selectedOptions, child) {
        return Column(
          children:
              options.map((option) {
                final isSelected = selectedOptions.contains(option);

                return Column(
                  children: [
                    GestureDetector(
                      onTap: () => _toggleOption(option),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                displayText(option),
                                style:
                                    isSelected
                                        ? FontPalette.fBlack_16_600
                                        : FontPalette.fBlack_16_500,
                              ),
                            ),
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              width: 21.w,
                              height: 21.h,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color:
                                      isSelected
                                          ? Colors.transparent
                                          : ColorPalette.fD1D1D1,
                                  width: 1,
                                ),
                                color:
                                    isSelected
                                        ? ColorPalette.secondaryColor
                                        : Colors.transparent,
                              ),
                              child:
                                  isSelected
                                      ? const Icon(
                                        Icons.check,
                                        size: 14,
                                        color: Colors.white,
                                      )
                                      : null,
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (option != options.last)
                      Divider(color: ColorPalette.fF1F1F1, height: 1),
                  ],
                );
              }).toList(),
        );
      },
    );
  }
}

class BottomSheetHeader extends StatelessWidget {
  final String title;
  final VoidCallback onClose;

  const BottomSheetHeader({
    super.key,
    required this.title,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: FontPalette.fBlack_18_600,
        ),
        GestureDetector(
          onTap: onClose,
          child: Container(
            padding: EdgeInsets.all(6.r),
            decoration: const BoxDecoration(
              color: ColorPalette.fF6F6F6,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.close_rounded,
              size: 16,
              color: ColorPalette.black,
            ),
          ),
        ),
      ],
    );
  }
}

extension ShimmerExtension on Widget {
  Widget showGradientShimmer() {
    return Shimmer.fromColors(
      baseColor: const Color(0xFFE5E7EB),
      highlightColor: const Color(0xFFF3F4F6),
      child: this,
    );
  }
}
