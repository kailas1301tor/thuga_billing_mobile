// lib/src/customers/view/customer_crud_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tuple/tuple.dart';
import 'package:vyapapp/res/constants/string_constants.dart';
import 'package:vyapapp/res/enums/enums.dart';
import 'package:vyapapp/res/styles/color_palette.dart';
import 'package:vyapapp/utils/common_widgets/common_app_bar.dart';
import 'package:vyapapp/utils/common_widgets/common_bottom_sheet.dart';
import 'package:vyapapp/utils/common_widgets/common_cached_network_image.dart';
import 'package:vyapapp/utils/common_widgets/common_dialog_box.dart';
import 'package:vyapapp/utils/common_widgets/common_empty_state.dart';
import 'package:vyapapp/utils/common_widgets/common_nav_bar_button.dart';
import 'package:vyapapp/utils/common_widgets/common_scaffold.dart';
import 'package:vyapapp/utils/common_widgets/common_switch_state.dart';
import 'package:vyapapp/utils/common_widgets/common_text_form_field.dart';
import 'package:vyapapp/utils/common_widgets/common_search_bar.dart';
import 'package:vyapapp/utils/common_widgets/common_refresh_indicator.dart';
import 'package:vyapapp/utils/common_widgets/primary_button.dart';
import 'widget/customer_card_widget.dart';
import '../model/customer_model.dart';
import '../notifier/customers_notifier.dart';
import '../state/customers_state.dart';

class CustomerCrudScreen extends ConsumerWidget {
  const CustomerCrudScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.appColors;
    final state = ref.watch(customersNotifierProvider);
    final notifier = ref.read(customersNotifierProvider.notifier);

    return CommonScaffold(
      backgroundColor: colors.background,
      appBar: CommonAppBar(
        title: Strings.customersTitle,
        actions: [
          CommonNavBarButton(
            icon: Icon(Icons.add_rounded, size: 24.r, color: colors.primaryText),
            onTap: () {
              notifier.clearForm();
              _showCustomerSheet(context, ref, notifier, null);
            },
          ),
        ],
      ),
      body: CommonSwitchState(
        loaderState: state.loaderState,
        reload: () => notifier.fetchCustomers(),
        child: _buildBody(context, colors, state, notifier),
      ),
    );
  }

  Widget _buildBody(BuildContext context, AppColors colors, CustomersState state, CustomersNotifier notifier) {
    if (state.loaderState == LoaderState.noData || state.response?.results.data == null) {
      return Center(
        child: CommonEmptyState(
          title: Strings.noDataTitle,
          message: Strings.noDataMessage,
          buttonText: Strings.addCustomer,
          onPressed: () => _showCustomerSheet(context, null, notifier, null),
        ),
      );
    }

    final customers = state.response!.results.data;
    final query = state.searchQuery.toLowerCase();
    final filteredCustomers = query.isEmpty 
        ? customers 
        : customers.where((e) => e.name.toLowerCase().contains(query) || e.phoneNumber.contains(query)).toList();

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 8.h),
          child: CommonSearchBar(
            controller: notifier.searchController,
            focusNode: notifier.searchFocusNode,
            hintText: 'Search customers...',
            onClear: notifier.clearSearch,
          ),
        ),
        Expanded(
          child: filteredCustomers.isEmpty
              ? Center(
                  child: CommonEmptyState(
                    title: 'No Matches',
                    message: 'No customers matched your search.',
                    buttonText: 'Clear Search',
                    onPressed: notifier.clearSearch,
                  ),
                )
              : CommonRefreshIndicator(
                  onRefresh: () => notifier.fetchCustomers(),
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                    itemCount: filteredCustomers.length,
                    itemBuilder: (context, index) {
                      final customer = filteredCustomers[index];
                      return CustomerCardWidget(
                        customer: customer,
                        onEdit: () => _showCustomerSheet(context, null, notifier, customer),
                        onDelete: () => _showDeleteDialog(context, notifier, customer),
                      );
                    },
                  ),
                ),
        ),
      ],
    );
  }

  void _showCustomerSheet(BuildContext context, WidgetRef? ref, CustomersNotifier notifier, CustomerModel? customer) {
    final isEditing = customer != null;
    if (isEditing) {
      notifier.nameController.text = customer.name;
      notifier.phoneController.text = customer.phoneNumber;
    } else {
      notifier.clearForm();
    }

    CommonBottomSheet.show(
      context: context,
      isScrollControlled: true,
      title: isEditing ? Strings.editCustomer : Strings.addCustomer,
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (isEditing && customer.image != null && customer.image!.isNotEmpty) ...[
                Align(
                  alignment: Alignment.center,
                  child: CommonCachedNetworkImage(
                    imageUrl: customer.image!,
                    width: 80.r,
                    height: 80.r,
                    memCacheWidth: 80,
                    memCacheHeight: 80,
                    borderRadius: 40.r,
                    fit: BoxFit.cover,
                  ),
                ),
                16.verticalSpace,
              ],
              CommonTextFormField(
                controller: notifier.nameController,
                hintText: Strings.customerName,
                inputAction: TextInputAction.next,
              ),
              16.verticalSpace,
              CommonTextFormField(
                controller: notifier.phoneController,
                hintText: Strings.phoneNumber,
                inputType: TextInputType.phone,
                inputAction: TextInputAction.done,
              ),
              24.verticalSpace,
              Consumer(
                builder: (context, ref, _) {
                  final loaders = ref.watch(
                    customersNotifierProvider.select(
                      (s) => Tuple2(s.saveCustomerLoader, s.updateCustomerLoader),
                    ),
                  );
                  final isLoading = isEditing ? loaders.item2 : loaders.item1;

                  return AnimatedBuilder(
                    animation: Listenable.merge([
                      notifier.nameController,
                      notifier.phoneController,
                    ]),
                    builder: (context, _) {
                      final isValid =
                          notifier.nameController.text.trim().isNotEmpty;

                      return PrimaryButton(
                        text: Strings.save,
                        isLoading: isLoading,
                        onPressed: isValid
                            ? () async {
                                final nav = Navigator.of(context);
                                final success = isEditing
                                    ? await notifier.updateCustomer(customer.id)
                                    : await notifier.createCustomer();
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

  void _showDeleteDialog(BuildContext context, CustomersNotifier notifier, CustomerModel customer) {
    showDialog(
      context: context,
      builder: (_) => Consumer(
        builder: (context, ref, _) {
          final isDeleting = ref.watch(
            customersNotifierProvider.select(
              (value) => value.deleteCustomerLoader,
            ),
          );
          return CommonDialogBox(
            title: Strings.delete,
            message: Strings.deleteCustomerConfirm,
            primaryLabel: Strings.delete,
            secondaryLabel: Strings.cancel,
            isLoadingPrimary: isDeleting,
            autoPop: false,
            onPrimary: () async {
              final nav = Navigator.of(context);
              final success = await notifier.deleteCustomer(customer.id);
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
