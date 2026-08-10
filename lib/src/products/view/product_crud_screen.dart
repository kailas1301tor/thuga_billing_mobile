// lib/src/products/view/product_crud_screen.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tuple/tuple.dart';
import 'package:thuga/res/constants/string_constants.dart';
import 'package:thuga/res/styles/color_palette.dart';
import 'package:thuga/res/styles/font_palette.dart';
import 'package:thuga/utils/common_widgets/common_app_bar.dart';
import 'package:thuga/utils/common_widgets/common_bottom_sheet.dart';
import 'package:thuga/utils/common_widgets/common_cached_network_image.dart';
import 'package:thuga/utils/common_widgets/common_dialog_box.dart';
import 'package:thuga/utils/common_widgets/common_nav_bar_button.dart';
import 'package:thuga/utils/common_widgets/common_scaffold.dart';
import 'package:thuga/utils/common_widgets/common_search_bar.dart';
import 'package:thuga/utils/common_widgets/common_switch_state.dart';
import 'package:thuga/utils/common_widgets/common_text_form_field.dart';
import 'package:thuga/utils/common_widgets/common_refresh_indicator.dart';
import 'package:thuga/utils/common_widgets/primary_button.dart';
import 'widget/product_card_widget.dart';
import '../model/product_crud_model.dart';
import '../notifier/products_notifier.dart';
import '../state/products_state.dart';
import 'package:thuga/res/enums/enums.dart';
import 'package:thuga/src/categories/notifier/categories_notifier.dart';
import 'package:thuga/src/categories/model/category_model.dart';
import 'package:thuga/src/main/model/dropdown_model.dart';
import 'package:thuga/src/main/notifier/dropdowns_notifier.dart';
import 'package:thuga/utils/common_widgets/bottomsheet_content.dart';
import 'package:thuga/utils/helpers/extensions.dart';

class ProductCrudScreen extends ConsumerWidget {
  const ProductCrudScreen({super.key});

  Widget _buildFieldLabel(BuildContext context, String label) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Text(
        label,
        style: FontPalette.base600(
          13,
          color: context.appColors.primaryText,
        ),
      ),
    );
  }

  Widget _buildLabeledField({
    required BuildContext context,
    required String label,
    required Widget child,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildFieldLabel(context, label),
        child,
      ],
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.appColors;
    final state = ref.watch(productsProvider);
    final notifier = ref.read(productsProvider.notifier);

    return CommonScaffold(
      backgroundColor: colors.background,
      appBar: CommonAppBar(
        title: Strings.productsTitle,
        actions: [
          CommonNavBarButton(
            icon: Icon(
              Icons.add_rounded,
              size: 24.r,
              color: colors.primaryText,
            ),
            onTap: () => _showProductSheet(context, null, notifier, null),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 8.h),
            child: Row(
              children: [
                Expanded(
                  child: CommonSearchBar(
                    controller: notifier.searchController,
                    focusNode: notifier.searchFocusNode,
                    hintText: 'Search products...',
                    onClear: notifier.clearSearch,
                  ),
                ),
                8.horizontalSpace,
                CommonNavBarButton(
                  icon: Icon(Icons.sort_rounded, color: colors.primaryText),
                  onTap: () {
                    showSingleSelectBottomSheet<String>(
                      context: context,
                      ref: ref,
                      title: 'Sort By',
                      options: const ['lowest', 'highest'],
                      currentValue: state.sort,
                      onSelected: notifier.setSort,
                      displayText: (val) {
                        if (val == 'lowest') return 'Lowest Price';
                        if (val == 'highest') return 'Highest Price';
                        return '';
                      },
                    );
                  },
                ),
              ],
            ),
          ),
          Consumer(
            builder: (context, ref, _) {
              final categoryResponse = ref.watch(
                categoriesProvider.select((c) => c.response),
              );
              final categories = categoryResponse?.results.data ?? [];
              final selectedFilter = state.filterCategoryId;
              final categoryLoader = ref.watch(
                categoriesProvider.select((value) => value.loaderState),
              );
              if (categoryLoader == LoaderState.loading) {
                return const CategoryShimmerWidget();
              }
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ChoiceChip(
                      label: Text(
                        'All',
                        style: FontPalette.base400(
                          14,
                          color: selectedFilter == null
                              ? ColorPalette.white
                              : colors.primaryText,
                        ),
                      ),
                      selected: selectedFilter == null,
                      selectedColor: colors.primary,
                      showCheckmark: false,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100.r),
                        side: BorderSide(
                          color: selectedFilter == null
                              ? colors.primary
                              : colors.inputBorder,
                        ),
                      ),
                      onSelected: (_) => notifier.filterByCategory(null),
                    ),
                    8.horizontalSpace,
                    ...categories.map((cat) {
                      final isSelected = selectedFilter == cat.id;
                      return Padding(
                        padding: EdgeInsets.only(right: 8.w),
                        child: ChoiceChip(
                          label: Text(
                            cat.name,
                            style: FontPalette.base400(
                              14,
                              color: isSelected
                                  ? ColorPalette.white
                                  : colors.primaryText,
                            ),
                          ),
                          selected: isSelected,
                          selectedColor: colors.primary,
                          showCheckmark: false,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100.r),
                            side: BorderSide(
                              color: isSelected
                                  ? colors.primary
                                  : colors.inputBorder,
                            ),
                          ),
                          onSelected: (_) => notifier.filterByCategory(cat.id),
                        ),
                      );
                    }),
                  ],
                ),
              );
            },
          ),
          Expanded(
            child: CommonSwitchState(
              loaderState: state.loaderState,
              reload: () => notifier.fetchProducts(),
              child: _buildBody(context, colors, state, notifier),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(
    BuildContext context,
    AppColors colors,
    ProductsState state,
    ProductsNotifier notifier,
  ) {
    final products = state.response?.results.data ?? [];
    final isLoadingMore = state.isLoadingMore;
    return CommonRefreshIndicator(
      onRefresh: () => notifier.fetchProducts(),
      child: ListView.builder(
        controller: notifier.scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        itemCount: products.length + (isLoadingMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == products.length) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              child: Center(
                child: SizedBox(
                  width: 24.r,
                  height: 24.r,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.w,
                    color: colors.primary,
                  ),
                ),
              ),
            );
          }
          final product = products[index];
          final isToggling = state.togglingProductIds.contains(product.id);
          return ProductCardWidget(
            product: product,
            isToggling: isToggling,
            onEdit: () => _showProductSheet(context, null, notifier, product),
            onDelete: () => _showDeleteDialog(context, notifier, product),
            onToggleStatus: isToggling ? null : (value) => notifier.toggleProductStatus(product.id, value),
          );
        },
      ),
    );
  }

  void _showProductSheet(
    BuildContext context,
    WidgetRef? ref,
    ProductsNotifier notifier,
    ProductCrudModel? product,
  ) {
    final isEditing = product != null;
    if (isEditing) {
      notifier.nameController.text = product.name;
      notifier.priceController.text = product.price.toString();
      notifier.purchasePriceController.text = product.purchasePrice == null
          ? ''
          : product.purchasePrice!.toString();
      notifier.barcodeController.text = product.barcode ?? '';
      notifier.qtyController.text = product.quantity == null
          ? ''
          : (product.quantity! % 1 == 0
              ? product.quantity!.toInt().toString()
              : product.quantity.toString());
      notifier.sgstController.text =
          product.sgst == null ? '' : product.sgst!.toString();
      notifier.cgstController.text =
          product.cgst == null ? '' : product.cgst!.toString();
      notifier.selectCategory(product.categoryId, name: product.categoryName);
      notifier.selectUnit(product.unit);
      notifier.initializeEdit(isQuickProduct: product.isQuickProduct);
    } else {
      notifier.clearForm();
    }

    CommonBottomSheet.show(
      context: context,
      isScrollControlled: true,
      title: isEditing ? Strings.editProduct : Strings.addProduct,
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Image Picker Section (Aligned to Left & Enlarged)
              Consumer(
                builder: (context, ref, _) {
                  final selectedImagePath = ref.watch(
                    productsProvider.select((s) => s.selectedImagePath),
                  );
                  final hasImage =
                      selectedImagePath != null ||
                      (isEditing &&
                          product.image != null &&
                          product.image!.isNotEmpty);

                  return Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: notifier.pickImage,
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            width: 140.r,
                            height: 140.r,
                            decoration: BoxDecoration(
                              color: context.appColors.inputBackground,
                              borderRadius: BorderRadius.circular(16.r),
                              border: Border.all(
                                color: context.appColors.inputBorder,
                                width: 1.5.w,
                              ),
                            ),
                            clipBehavior: Clip.antiAlias,
                            child: selectedImagePath != null
                                ? Image.file(
                                    File(selectedImagePath),
                                    fit: BoxFit.cover,
                                  )
                                : (isEditing &&
                                      product.image != null &&
                                      product.image!.isNotEmpty)
                                ? CommonCachedNetworkImage(
                                    imageUrl: product.image!,
                                    width: 140.r,
                                    height: 140.r,
                                    memCacheWidth: 200,
                                    memCacheHeight: 200,
                                    fit: BoxFit.cover,
                                  )
                                : Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.photo_camera, size: 30.r),
                                      8.verticalSpace,
                                      Text(
                                        'Add Image',
                                        style: FontPalette.base500(
                                          12,
                                          color: context.appColors.primaryText,
                                        ),
                                      ),
                                    ],
                                  ),
                          ),
                          if (hasImage) ...[
                            // Edit overlay badge in bottom-right corner
                            Positioned(
                              bottom: 6.r,
                              right: 6.r,
                              child: Container(
                                padding: EdgeInsets.all(6.r),
                                decoration: BoxDecoration(
                                  color: context.appColors.primary,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(
                                        alpha: 0.15,
                                      ),
                                      blurRadius: 4,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  Icons.camera_alt_rounded,
                                  size: 14.r,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                          if (selectedImagePath != null)
                            Positioned(
                              top: -6.r,
                              right: -6.r,
                              child: GestureDetector(
                                onTap: () {
                                  notifier.clearImage();
                                },
                                child: Container(
                                  padding: EdgeInsets.all(6.r),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withValues(alpha: 0.7),
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 1.5.w,
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.close_rounded,
                                    size: 12.r,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              16.verticalSpace,
              _buildLabeledField(
                context: context,
                label: Strings.productName,
                child: CommonTextFormField(
                  controller: notifier.nameController,
                  hintText: Strings.productName,
                  inputAction: TextInputAction.next,
                ),
              ),
              16.verticalSpace,
              Consumer(
                builder: (context, ref, child) {
                  final categorySelection = ref.watch(
                    productsProvider.select(
                      (s) => Tuple2(s.selectedCategoryId, s.selectedCategoryName),
                    ),
                  );
                  final selectedCategoryId = categorySelection.item1;
                  final selectedCategoryName = categorySelection.item2;
                  final categories =
                      ref
                          .watch(categoriesProvider)
                          .response
                          ?.results
                          .data ??
                      [];

                  final selectedCategory = categories.firstWhereOrNull(
                    (c) => c.id == selectedCategoryId,
                  );
                  final hasCategorySelection = selectedCategoryId != null;
                  final categoryDisplayName =
                      selectedCategoryName ??
                      selectedCategory?.name ??
                      Strings.selectCategory;

                  return _buildLabeledField(
                    context: context,
                    label: Strings.categoryName,
                    child: GestureDetector(
                      onTap: () {
                        final categoriesNotifier =
                            ref.read(categoriesProvider.notifier);
                        showSingleSelectBottomSheet<CategoryModel>(
                          context: context,
                          ref: ref,
                          title: Strings.selectCategory,
                          options: categories,
                          currentValue: selectedCategoryId != null
                              ? (selectedCategory ??
                                  CategoryModel(
                                    id: selectedCategoryId,
                                    name: selectedCategoryName ?? '',
                                  ))
                              : null,
                          onSelected: (cat) =>
                              notifier.selectCategory(cat.id, name: cat.name),
                          displayText: (cat) => cat.name,
                          useRemoteSearch: true,
                          onOpen: categoriesNotifier.prepareCategoryPicker,
                          onDismiss: categoriesNotifier.resetAfterCategoryPicker,
                          onSearchChanged: categoriesNotifier.searchCategories,
                          onLoadMore: categoriesNotifier.loadMoreCategories,
                          watchOptions: (sheetRef) => sheetRef.watch(
                            categoriesProvider.select(
                              (s) => s.response?.results.data ?? [],
                            ),
                          ),
                          watchLoaderState: (sheetRef) => sheetRef.watch(
                            categoriesProvider.select((s) => s.loaderState),
                          ),
                          watchIsLoadingMore: (sheetRef) => sheetRef.watch(
                            categoriesProvider.select((s) => s.isLoadingMore),
                          ),
                          optionEquals: (a, b) => a.id == b.id,
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 16.h,
                        ),
                        decoration: BoxDecoration(
                          color: context.appColors.inputBackground,
                          borderRadius: BorderRadius.circular(14.r),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                categoryDisplayName,
                                style: FontPalette.base400(
                                  14,
                                  color: hasCategorySelection
                                      ? context.appColors.primaryText
                                      : context.appColors.secondaryText,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: context.appColors.secondaryText,
                              size: 20.r,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              16.verticalSpace,
              Consumer(
                builder: (context, ref, _) {
                  final selectedUnitId = ref.watch(
                    productsProvider.select((s) => s.selectedUnitId),
                  );
                  final dropdowns = ref.watch(
                    dropdownsProvider.select((s) => s.data),
                  );
                  final selectableUnits = dropdowns.selectableProductUnits;
                  final selectedUnit = dropdowns.unitById(selectedUnitId);

                  if (isEditing) {
                    return _buildLabeledField(
                      context: context,
                      label: Strings.unit,
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 16.h,
                        ),
                        decoration: BoxDecoration(
                          color: context.appColors.inputBackground,
                          borderRadius: BorderRadius.circular(14.r),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              selectedUnit?.name ??
                                  (product.unit != null && product.unit!.isNotEmpty
                                      ? dropdowns.displayNameForUnit(product.unit)
                                      : Strings.notAvailable),
                              style: FontPalette.base400(
                                14,
                                color: context.appColors.primaryText,
                              ),
                            ),
                            4.verticalSpace,
                            Text(
                              Strings.unitLockedHint,
                              style: FontPalette.base400(
                                12,
                                color: context.appColors.secondaryText,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  return _buildLabeledField(
                    context: context,
                    label: Strings.unitRequired,
                    child: GestureDetector(
                      onTap: () {
                        showSingleSelectBottomSheet<DropdownUnitItemModel>(
                          context: context,
                          ref: ref,
                          title: Strings.selectUnit,
                          options: selectableUnits,
                          currentValue: selectedUnit,
                          onSelected: (unit) => notifier.selectUnit(unit.id),
                          displayText: (unit) => unit.name,
                          height: 0.6.sh,
                          optionEquals: (a, b) => a.id == b.id,
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 16.h,
                        ),
                        decoration: BoxDecoration(
                          color: context.appColors.inputBackground,
                          borderRadius: BorderRadius.circular(14.r),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                selectedUnit?.name ?? Strings.selectUnit,
                                style: FontPalette.base400(
                                  14,
                                  color: selectedUnit != null
                                      ? context.appColors.primaryText
                                      : context.appColors.secondaryText,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: context.appColors.secondaryText,
                              size: 20.r,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              16.verticalSpace,
              _buildLabeledField(
                context: context,
                label: Strings.price,
                child: CommonTextFormField(
                  controller: notifier.priceController,
                  hintText: Strings.price,
                  inputType: const TextInputType.numberWithOptions(decimal: true),
                  inputAction: TextInputAction.next,
                ),
              ),
              16.verticalSpace,
              _buildLabeledField(
                context: context,
                label: Strings.purchasePrice,
                child: CommonTextFormField(
                  controller: notifier.purchasePriceController,
                  hintText: Strings.purchasePrice,
                  inputType: const TextInputType.numberWithOptions(decimal: true),
                  inputAction: TextInputAction.next,
                ),
              ),
              16.verticalSpace,
              _buildLabeledField(
                context: context,
                label: Strings.barcode,
                child: CommonTextFormField(
                  controller: notifier.barcodeController,
                  hintText: Strings.barcode,
                  inputType: TextInputType.text,
                  inputAction: TextInputAction.next,
                ),
              ),
              16.verticalSpace,
              _buildLabeledField(
                context: context,
                label: Strings.quantity,
                child: CommonTextFormField(
                  controller: notifier.qtyController,
                  hintText: Strings.quantity,
                  inputType: const TextInputType.numberWithOptions(decimal: true),
                  inputAction: TextInputAction.next,
                ),
              ),
              16.verticalSpace,
              _buildLabeledField(
                context: context,
                label: Strings.sgst,
                child: CommonTextFormField(
                  controller: notifier.sgstController,
                  hintText: Strings.sgstPercentHint,
                  inputType: const TextInputType.numberWithOptions(decimal: true),
                  inputAction: TextInputAction.next,
                ),
              ),
              16.verticalSpace,
              _buildLabeledField(
                context: context,
                label: Strings.cgst,
                child: CommonTextFormField(
                  controller: notifier.cgstController,
                  hintText: Strings.cgstPercentHint,
                  inputType: const TextInputType.numberWithOptions(decimal: true),
                  inputAction: TextInputAction.done,
                ),
              ),
              16.verticalSpace,
              // Quick Product Toggle
              Consumer(
                builder: (context, ref, _) {
                  final isQuickProduct = ref.watch(
                    productsProvider.select((s) => s.isQuickProduct),
                  );

                  return SwitchListTile.adaptive(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      'Quick Product',
                      style: FontPalette.base400(
                        14,
                        color: context.appColors.primaryText,
                      ),
                    ),
                    subtitle: Text(
                      'Instantly add to bill from the quick actions section',
                      style: FontPalette.base400(
                        12,
                        color: context.appColors.secondaryText,
                      ),
                    ),
                    value: isQuickProduct,
                    onChanged: notifier.toggleQuickProduct,
                    activeThumbColor: context.appColors.primary,
                  );
                },
              ),
              24.verticalSpace,
              Consumer(
                builder: (context, ref, _) {
                  final loaders = ref.watch(
                    productsProvider.select(
                      (value) => Tuple2(
                        value.saveProductLoader,
                        value.updateProductLoader,
                      ),
                    ),
                  );
                  final isLoading = isEditing ? loaders.item2 : loaders.item1;

                  return AnimatedBuilder(
                    animation: Listenable.merge([
                      notifier.nameController,
                      notifier.priceController,
                    ]),
                    builder: (context, _) {
                      final isValid =
                          notifier.nameController.text.trim().isNotEmpty &&
                          notifier.priceController.text.trim().isNotEmpty;

                      return PrimaryButton(
                        text: Strings.save,
                        isLoading: isLoading,
                        onPressed: isValid
                            ? () async {
                                final nav = Navigator.of(context);
                                final success = isEditing
                                    ? await notifier.updateProduct(product.id)
                                    : await notifier.createProduct();
                                if (success) {
                                  nav.pop();
                                }
                              }
                            : null,
                      );
                    },
                  );
                },
              ),
              16.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }

  void _showDeleteDialog(
    BuildContext context,
    ProductsNotifier notifier,
    ProductCrudModel product,
  ) {
    showDialog(
      context: context,
      builder: (_) => Consumer(
        builder: (context, ref, _) {
          final isDeleting = ref.watch(
            productsProvider.select(
              (value) => value.deleteProductLoader,
            ),
          );
          return CommonDialogBox(
            title: Strings.delete,
            message: Strings.deleteProductConfirm,
            primaryLabel: Strings.delete,
            secondaryLabel: Strings.cancel,
            isLoadingPrimary: isDeleting,
            autoPop: false,
            onPrimary: () async {
              final nav = Navigator.of(context);
              final success = await notifier.deleteProduct(product.id);
              if (success) {
                nav.pop();
              }
            },
            onSecondary: () => Navigator.of(context).pop(),
          );
        },
      ),
    );
  }
}

class CategoryShimmerWidget extends StatelessWidget {
  const CategoryShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Row(
        children: List.generate(
          5,
          (index) => Padding(
            padding: EdgeInsets.only(right: 8.w),
            child: Container(
              width: 80.w,
              height: 32.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(100.r),
              ),
            ),
          ),
        ),
      ).showShimmer(),
    );
  }
}
