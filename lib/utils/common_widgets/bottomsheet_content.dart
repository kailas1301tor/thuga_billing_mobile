import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../res/enums/enums.dart';
import '../../res/styles/color_palette.dart';
import '../../res/styles/font_palette.dart';

import 'primary_button.dart';
import 'common_search_bar.dart';

class BottomSheetContent extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;

  const BottomSheetContent({super.key, required this.child, this.padding});

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOutBack,
      child: Container(
        width: double.infinity,
        padding:
            padding ?? EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: colors.surface,
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
                color: colors.inputBorder,
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
    builder: (_) => SingleSelectBottomSheetBody<T>(
      title: title,
      options: options,
      currentValue: currentValue,
      onSelected: onSelected,
      displayText: displayText,
      loaderState: loaderState,
      height: height,
    ),
  );
}

class SingleSelectBottomSheetBody<T> extends StatefulWidget {
  final String title;
  final List<T> options;
  final T? currentValue;
  final Function(T) onSelected;
  final String Function(T) displayText;
  final LoaderState loaderState;
  final double? height;

  const SingleSelectBottomSheetBody({
    super.key,
    required this.title,
    required this.options,
    required this.currentValue,
    required this.onSelected,
    required this.displayText,
    required this.loaderState,
    this.height,
  });

  @override
  State<SingleSelectBottomSheetBody<T>> createState() =>
      _SingleSelectBottomSheetBodyState<T>();
}

class _SingleSelectBottomSheetBodyState<T>
    extends State<SingleSelectBottomSheetBody<T>> {
  late final TextEditingController _searchController;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final filteredOptions = widget.options.where((option) {
      final text = widget.displayText(option).toLowerCase();
      return text.contains(_searchQuery.toLowerCase());
    }).toList();

    return BottomSheetContent(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BottomSheetHeader(
            title: widget.title,
            onClose: () => Navigator.pop(context),
          ),
          16.verticalSpace,
          CommonSearchBar(
            controller: _searchController,
            hintText: 'Search...',
            onChanged: (val) {
              setState(() {
                _searchQuery = val;
              });
            },
            onClear: () {
              setState(() {
                _searchQuery = '';
              });
            },
          ),
          16.verticalSpace,
          SafeArea(
            child: widget.loaderState == LoaderState.loading
                ? Column(
                    children: List.generate(
                      3,
                      (index) => Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.h),
                        child: Row(
                          children: [
                            Flexible(
                              flex: 4,
                              child: Container(
                                height: 25.h,
                                width: double.infinity,
                                color: colors.inputBackground,
                              ).showGradientShimmer(colors),
                            ),
                            const Spacer(),
                            Container(
                              margin: EdgeInsets.all(4.h),
                              height: 13.h,
                              width: 13.h,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                            ).showGradientShimmer(colors),
                          ],
                        ),
                      ),
                    ),
                  )
                : widget.options.isEmpty
                ? Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 32.h),
                      child: Text(
                        'No data found',
                        style: FontPalette.base500(
                          14,
                          color: colors.secondaryText,
                        ),
                      ),
                    ),
                  )
                : filteredOptions.isEmpty
                ? Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 32.h),
                      child: Text(
                        'No results found',
                        style: FontPalette.base500(
                          14,
                          color: colors.secondaryText,
                        ),
                      ),
                    ),
                  )
                : widget.height != null
                ? SizedBox(
                    height: widget.height,
                    child: SingleChildScrollView(
                      child: SingleSelectOptionsList<T>(
                        options: filteredOptions,
                        selectedOptionNotifier: ValueNotifier<T?>(
                          widget.currentValue,
                        ),
                        onOptionSelected: (option) {
                          if (option == widget.currentValue) {
                            Navigator.pop(context);
                            return;
                          }
                          Future.delayed(const Duration(milliseconds: 100), () {
                            widget.onSelected(option);
                            if (context.mounted) {
                              Navigator.pop(context);
                            }
                          });
                        },
                        displayText: widget.displayText,
                      ),
                    ),
                  )
                : ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * 0.6,
                    ),
                    child: SingleChildScrollView(
                      child: SingleSelectOptionsList<T>(
                        options: filteredOptions,
                        selectedOptionNotifier: ValueNotifier<T?>(
                          widget.currentValue,
                        ),
                        onOptionSelected: (option) {
                          if (option == widget.currentValue) {
                            Navigator.pop(context);
                            return;
                          }
                          Future.delayed(const Duration(milliseconds: 100), () {
                            widget.onSelected(option);
                            if (context.mounted) {
                              Navigator.pop(context);
                            }
                          });
                        },
                        displayText: widget.displayText,
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

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
    final colors = context.appColors;

    return ValueListenableBuilder<T?>(
      valueListenable: selectedOptionNotifier,
      builder: (context, selectedOption, child) {
        return Column(
          children: options.map((option) {
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
                      children: [
                        Text(
                          displayText(option),
                          style: FontPalette.base500(
                            16,
                            color: colors.primaryText,
                          ),
                        ),
                        const Spacer(),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          width: 21.w,
                          height: 21.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isSelected
                                  ? colors.primary
                                  : colors.inputBorder,
                              width: 1,
                            ),
                          ),
                          child: Container(
                            margin: EdgeInsets.all(4.h),
                            height: 13.h,
                            width: 13.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isSelected
                                  ? colors.primary
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
                  Divider(color: colors.inputBorder, height: 1),
              ],
            );
          }).toList(),
        );
      },
    );
  }
}

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
    builder: (_) => BottomSheetContent(
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
              text: 'Save',
            ),
          ),
        ],
      ),
    ),
  ).then((_) => selectedOptionsNotifier.dispose());
}

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

    if (displayText(option) == 'None') {
      selectedOptionsNotifier.value = [option];
    } else {
      currentSelections.removeWhere((item) => displayText(item) == 'None');

      if (currentSelections.contains(option)) {
        currentSelections.remove(option);
        if (currentSelections.isEmpty) {
          final noneOption = options.firstWhere(
            (item) => displayText(item) == 'None',
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
    final colors = context.appColors;

    return ValueListenableBuilder<List<T>>(
      valueListenable: selectedOptionsNotifier,
      builder: (context, selectedOptions, child) {
        return Column(
          children: options.map((option) {
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
                                FontPalette.base500(
                                  16,
                                  color: colors.primaryText,
                                ).copyWith(
                                  fontWeight: isSelected
                                      ? FontWeight.w600
                                      : FontWeight.w500,
                                ),
                          ),
                        ),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          width: 21.w,
                          height: 21.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isSelected
                                  ? Colors.transparent
                                  : colors.inputBorder,
                              width: 1,
                            ),
                            color: isSelected
                                ? colors.primary
                                : Colors.transparent,
                          ),
                          child: isSelected
                              ? Icon(
                                  Icons.check,
                                  size: 14.r,
                                  color: colors.surface,
                                )
                              : null,
                        ),
                      ],
                    ),
                  ),
                ),
                if (option != options.last)
                  Divider(color: colors.inputBorder, height: 1),
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
    final colors = context.appColors;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            title,
            style: FontPalette.base600(18, color: colors.primaryText),
          ),
        ),
        GestureDetector(
          onTap: onClose,
          child: Container(
            padding: EdgeInsets.all(6.r),
            decoration: BoxDecoration(
              color: colors.inputBackground,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.close_rounded,
              size: 16.r,
              color: colors.primaryText,
            ),
          ),
        ),
      ],
    );
  }
}

extension ShimmerExtension on Widget {
  Widget showGradientShimmer(AppColors colors) {
    return Shimmer.fromColors(
      baseColor: colors.inputBackground,
      highlightColor: colors.inputBorder,
      child: this,
    );
  }
}
