// lib/src/categories/view/category_crud_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tuple/tuple.dart';
import 'package:vyapapp/res/constants/string_constants.dart';
import 'package:vyapapp/res/styles/color_palette.dart';
import 'package:vyapapp/utils/common_widgets/common_app_bar.dart';
import 'package:vyapapp/utils/common_widgets/common_bottom_sheet.dart';
import 'package:vyapapp/utils/common_widgets/common_dialog_box.dart';
import 'package:vyapapp/utils/common_widgets/common_nav_bar_button.dart';
import 'package:vyapapp/utils/common_widgets/common_scaffold.dart';
import 'package:vyapapp/utils/common_widgets/common_switch_state.dart';
import 'package:vyapapp/utils/common_widgets/common_text_form_field.dart';
import 'package:vyapapp/utils/common_widgets/common_search_bar.dart';
import 'package:vyapapp/utils/common_widgets/common_refresh_indicator.dart';
import 'package:vyapapp/utils/common_widgets/primary_button.dart';
import 'widget/category_card_widget.dart';
import '../model/category_model.dart';
import '../notifier/categories_notifier.dart';

class CategoryCrudScreen extends ConsumerWidget {
  const CategoryCrudScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.appColors;
    final loaderState = ref.watch(
      categoriesNotifierProvider.select((value) => value.loaderState),
    );

    final categoryList = ref.watch(
      categoriesNotifierProvider.select(
        (value) => value.response?.results.data,
      ),
    );

    final notifier = ref.read(categoriesNotifierProvider.notifier);

    return CommonScaffold(
      backgroundColor: colors.background,
      appBar: CommonAppBar(
        title: Strings.categoriesTitle,
        actions: [
          CommonNavBarButton(
            icon: Icon(
              Icons.add_rounded,
              size: 24.r,
              color: colors.primaryText,
            ),
            onTap: () => _showCategorySheet(context, notifier, null),
          ),
        ],
      ),
      body: CommonSwitchState(
        loaderState: loaderState,
        reload: () => notifier.fetchCategories(),
        child: _buildBody(context, colors, categoryList ?? [], notifier),
      ),
    );
  }

  Widget _buildBody(
    BuildContext context,
    AppColors colors,
    List<CategoryModel> categoryList,
    CategoriesNotifier notifier,
  ) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 8.h),
          child: CommonSearchBar(
            controller: notifier.searchController,
            focusNode: notifier.searchFocusNode,
            hintText: 'Search categories...',
            onClear: notifier.clearSearch,
          ),
        ),
        Expanded(
          child: CommonRefreshIndicator(
            onRefresh: () => notifier.fetchCategories(),
            child: ListView.builder(
              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 8.h,
              ),
              itemCount: categoryList.length,
              itemBuilder: (context, index) {
                final category = (categoryList)[index];
                return CategoryCardWidget(
                  category: category,
                  onEdit: () =>
                      _showCategorySheet(context, notifier, category),
                  onDelete: () =>
                      _showDeleteDialog(context, notifier, category),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  void _showCategorySheet(
    BuildContext context,
    CategoriesNotifier notifier,
    CategoryModel? category,
  ) {
    final isEditing = category != null;
    notifier.nameController.text = isEditing ? category.name : '';

    CommonBottomSheet.show(
      context: context,
      isScrollControlled: true,
      title: isEditing ? Strings.editCategory : Strings.addCategory,
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
            CommonTextFormField(
              controller: notifier.nameController,
              hintText: Strings.categoryName,
              inputAction: TextInputAction.done,
            ),
            24.verticalSpace,
            Consumer(
              builder: (context, ref, _) {
                final loaders = ref.watch(
                  categoriesNotifierProvider.select(
                    (value) => Tuple2(
                      value.saveCategoryLoader,
                      value.updateCategoryLoader,
                    ),
                  ),
                );
                final isLoading = isEditing ? loaders.item2 : loaders.item1;

                return ValueListenableBuilder<TextEditingValue>(
                  valueListenable: notifier.nameController,
                  builder: (context, value, _) {
                    final isValid = value.text.trim().isNotEmpty;
                    return PrimaryButton(
                      text: Strings.save,
                      isLoading: isLoading,
                      onPressed: isValid
                          ? () async {
                              final nav = Navigator.of(context);
                              final success = isEditing
                                  ? await notifier.updateCategory(
                                      category.id,
                                      notifier.nameController.text.trim(),
                                    )
                                  : await notifier.createCategory();
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
    CategoriesNotifier notifier,
    CategoryModel category,
  ) {
    showDialog(
      context: context,
      builder: (_) => Consumer(
        builder: (context, ref, _) {
          final isDeleting = ref.watch(
            categoriesNotifierProvider
                .select((value) => value.deleteCategoryLoader),
          );
          return CommonDialogBox(
            title: Strings.delete,
            message: Strings.deleteCategoryConfirm,
            primaryLabel: Strings.delete,
            secondaryLabel: Strings.cancel,
            isLoadingPrimary: isDeleting,
            autoPop: false,
            onPrimary: () async {
              final nav = Navigator.of(context);
              final success = await notifier.deleteCategory(category.id);
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
