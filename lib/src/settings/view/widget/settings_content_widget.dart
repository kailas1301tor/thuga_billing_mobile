// lib/src/settings/view/widget/settings_content_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thuga/res/constants/string_constants.dart';
import 'package:thuga/res/styles/color_palette.dart';
import 'package:thuga/res/styles/font_palette.dart';
import 'package:thuga/res/styles/theme_provider.dart';
import 'package:thuga/src/auth/notifier/auth_notifier.dart';
import 'package:thuga/src/printer/model/printer_paper_size.dart';
import 'package:thuga/src/printer/notifier/printer_notifier.dart';
import 'package:thuga/utils/common_widgets/common_container.dart';
import 'package:thuga/utils/common_widgets/common_bottom_sheet.dart';
import 'package:thuga/utils/common_widgets/common_dialog_box.dart';
import 'package:thuga/utils/common_widgets/common_text_form_field.dart';
import 'package:thuga/utils/common_widgets/primary_button.dart';
import 'package:thuga/utils/helpers/working_hour_helper.dart';
import '../../notifier/settings_notifier.dart';
import '../../model/settings_model.dart';

class SettingsContentWidget extends ConsumerWidget {
  const SettingsContentWidget({
    super.key,
    required this.settings,
    this.embeddedInParentScroll = false,
  });

  final SettingsModel settings;

  /// When true, defers scrolling to a parent [CustomScrollView] (e.g. web layout).
  final bool embeddedInParentScroll;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.appColors;
    final notifier = ref.read(settingsProvider.notifier);
    final themeMode =
        ref.watch(themeNotifierProvider).value ?? ThemeMode.system;
    final firstLetter = settings.storeName.isNotEmpty
        ? settings.storeName.trim()[0].toUpperCase()
        : 'S';

    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
          // 1. Store Profile Section (Avatar + Company Details)
          _buildSectionHeader(context, 'Store Profile'),
          12.verticalSpace,
          CommonContainer(
            padding: EdgeInsets.all(16.r),
            borderRadius: 16.r,
            child: Column(
              children: [
                // Visual Profile Avatar with Store Details Header
                Row(
                  children: [
                    Container(
                      width: 54.r,
                      height: 54.r,
                      decoration: BoxDecoration(
                        color: colors.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(color: colors.primary, width: 1.5.w),
                      ),
                      child: Center(
                        child: Text(
                          firstLetter,
                          style: FontPalette.base700(20, color: colors.primary),
                        ),
                      ),
                    ),
                    16.horizontalSpace,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            settings.storeName.isNotEmpty
                                ? settings.storeName
                                : 'My Store',
                            style: FontPalette.base700(
                              16,
                              color: colors.primaryText,
                            ),
                          ),
                          4.verticalSpace,
                          Text(
                            settings.email.isNotEmpty
                                ? settings.email
                                : 'No email set',
                            style: FontPalette.base400(
                              12,
                              color: colors.secondaryText,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                20.verticalSpace,
                const Divider(height: 1),
                20.verticalSpace,

                // Input Forms
                CommonTextFormField(
                  controller: notifier.storeNameController,
                  title: 'Store Name',
                  hintText: 'Enter your business name',
                ),
                16.verticalSpace,
                CommonTextFormField(
                  controller: notifier.emailController,
                  title: 'Contact Email',
                  hintText: 'Enter your business email',
                  inputType: TextInputType.emailAddress,
                ),
                16.verticalSpace,
                CommonTextFormField(
                  controller: notifier.phoneController,
                  title: 'Contact Phone',
                  hintText: 'Enter your phone number',
                  inputType: TextInputType.phone,
                ),
                16.verticalSpace,
                CommonTextFormField(
                  controller: notifier.addressController,
                  title: 'Address',
                  hintText: 'Enter your address',
                ),
                16.verticalSpace,
                _buildWorkingHourFields(context, ref),
              ],
            ),
          ),
          20.verticalSpace,

          // 3. App Customization Section
          _buildSectionHeader(context, 'App Preference & Customization'),
          12.verticalSpace,
          CommonContainer(
            padding: EdgeInsets.all(16.r),
            borderRadius: 16.r,
            child: _buildThemeSelector(context, ref, themeMode),
          ),
          20.verticalSpace,
          _buildSectionHeader(context, Strings.printerSettingsTitle),
          12.verticalSpace,
          _buildPrinterSection(context, ref),
          24.verticalSpace,

          // 4. Save Button
          PrimaryButton(
            text: 'Save Preferences',
            onPressed: () => notifier.savePreferences(),
            height: 50,
            radius: 12,
          ),
          20.verticalSpace,

          // 5. Logout Button
          TextButton(
            onPressed: () => _showLogoutConfirmation(context, ref),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.logout_rounded, color: colors.errorText, size: 18.r),
                8.horizontalSpace,
                Text(
                  'Logout',
                  style: FontPalette.base600(15, color: colors.errorText),
                ),
              ],
            ),
          ),
          20.verticalSpace,
        ],
    );

    if (embeddedInParentScroll) {
      return content;
    }

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: content,
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    final colors = context.appColors;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Text(
        title,
        style: FontPalette.base700(13, color: colors.secondaryText),
      ),
    );
  }

  Widget _buildWorkingHourFields(BuildContext context, WidgetRef ref) {
    final startTime = ref.watch(
      settingsProvider.select((s) => s.startWorkingTime),
    );
    final endTime = ref.watch(
      settingsProvider.select((s) => s.endWorkingTime),
    );
    final notifier = ref.read(settingsProvider.notifier);

    return Row(
      children: [
        Expanded(
          child: _WorkingHourPickerField(
            title: Strings.startWorkingHour,
            valueText: displayWorkingHour(startTime),
            hintText: Strings.selectStartTime,
            onTap: () => _pickWorkingHour(
              context,
              initialTime: startTime,
              onPicked: notifier.setStartWorkingTime,
            ),
          ),
        ),
        12.horizontalSpace,
        Expanded(
          child: _WorkingHourPickerField(
            title: Strings.endWorkingHour,
            valueText: displayWorkingHour(endTime),
            hintText: Strings.selectEndTime,
            onTap: () => _pickWorkingHour(
              context,
              initialTime: endTime,
              onPicked: notifier.setEndWorkingTime,
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _pickWorkingHour(
    BuildContext context, {
    required TimeOfDay initialTime,
    required ValueChanged<TimeOfDay> onPicked,
  }) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: initialTime,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child ?? const SizedBox.shrink(),
        );
      },
    );
    if (picked != null) {
      onPicked(picked);
    }
  }

  Widget _buildThemeSelector(
    BuildContext context,
    WidgetRef ref,
    ThemeMode currentMode,
  ) {
    final colors = context.appColors;

    Widget buildOption({
      required ThemeMode mode,
      required String label,
      required IconData icon,
    }) {
      final isSelected = currentMode == mode;
      return Expanded(
        child: GestureDetector(
          onTap: () =>
              ref.read(themeNotifierProvider.notifier).setThemeMode(mode),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 12.h),
            decoration: BoxDecoration(
              color: isSelected
                  ? colors.primary.withValues(alpha: 0.08)
                  : colors.inputBackground,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: isSelected ? colors.primary : colors.inputBorder,
                width: 1.5.w,
              ),
            ),
            child: Column(
              children: [
                Icon(
                  icon,
                  size: 20.r,
                  color: isSelected ? colors.primary : colors.secondaryText,
                ),
                6.verticalSpace,
                Text(
                  label,
                  style: FontPalette.base700(
                    11,
                    color: isSelected ? colors.primary : colors.primaryText,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Row(
      children: [
        buildOption(
          mode: ThemeMode.light,
          label: 'Light',
          icon: Icons.light_mode_rounded,
        ),
        10.horizontalSpace,
        buildOption(
          mode: ThemeMode.dark,
          label: 'Dark',
          icon: Icons.dark_mode_rounded,
        ),
        10.horizontalSpace,
        buildOption(
          mode: ThemeMode.system,
          label: 'System',
          icon: Icons.settings_suggest_rounded,
        ),
      ],
    );
  }

  Widget _buildPrinterSection(BuildContext context, WidgetRef ref) {
    final colors = context.appColors;
    final printerState = ref.watch(printerProvider);
    final notifier = ref.read(printerProvider.notifier);

    return CommonContainer(
      padding: EdgeInsets.all(16.r),
      borderRadius: 16.r,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Icon(
                Icons.print_rounded,
                color: colors.primary,
                size: 20.r,
              ),
              10.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      printerState.isConnected
                          ? Strings.printerConnected
                          : Strings.noPrinterConnected,
                      style: FontPalette.base700(14, color: colors.primaryText),
                    ),
                    4.verticalSpace,
                    Text(
                      printerState.connectedPrinter?.displayName ??
                          Strings.bluetoothPrinterHint,
                      style: FontPalette.base400(
                        12,
                        color: colors.secondaryText,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          14.verticalSpace,
          Row(
            children: [
              Expanded(
                child: PrimaryButton(
                  text: Strings.managePrinter,
                  radius: 12,
                  height: 46,
                  onPressed: () => _showPrinterSheet(context, ref),
                ),
              ),
              if (printerState.isConnected) ...[
                10.horizontalSpace,
                Expanded(
                  child: PrimaryButton(
                    text: Strings.disconnectPrinter,
                    radius: 12,
                    height: 46,
                    backgroundColor: colors.inputBackground,
                    fontStyle: FontPalette.base700(
                      14,
                      color: colors.errorText,
                    ),
                    onPressed: notifier.disconnectPrinter,
                  ),
                ),
              ],
            ],
          ),
          if (printerState.errorMessage?.isNotEmpty == true) ...[
            10.verticalSpace,
            Text(
              printerState.errorMessage!,
              style: FontPalette.base500(11, color: colors.errorText),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildPaperWidthSelector(BuildContext context, WidgetRef ref) {
    final colors = context.appColors;
    final paperSize = ref.watch(
      printerProvider.select((state) => state.paperSize),
    );
    final printerNotifier = ref.read(printerProvider.notifier);

    return CommonContainer(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      borderRadius: 14.r,
      color: colors.inputBackground,
      child: Row(
        children: [
          Expanded(
            child: Text(
              Strings.paperWidth,
              style: FontPalette.base600(13, color: colors.primaryText),
            ),
          ),
          12.horizontalSpace,
          DropdownButtonHideUnderline(
            child: DropdownButton<PrinterPaperSize>(
              value: paperSize,
              borderRadius: BorderRadius.circular(12.r),
              style: FontPalette.base600(13, color: colors.primaryText),
              dropdownColor: colors.surface,
              items: const [
                DropdownMenuItem(
                  value: PrinterPaperSize.mm58,
                  child: Text(Strings.paperWidth58),
                ),
                DropdownMenuItem(
                  value: PrinterPaperSize.mm80,
                  child: Text(Strings.paperWidth80),
                ),
              ],
              onChanged: (value) {
                if (value != null) {
                  printerNotifier.setPaperSize(value);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showPrinterSheet(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(printerProvider.notifier);
    notifier.rescanPrinters();

    CommonBottomSheet.show(
      context: context,
      title: Strings.printerSettingsTitle,
      isScrollControlled: true,
      child: Consumer(
        builder: (context, ref, _) {
          final printerState = ref.watch(printerProvider);
          final printerNotifier = ref.read(printerProvider.notifier);
          final colors = context.appColors;

          return ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 420.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildPaperWidthSelector(context, ref),
                12.verticalSpace,
                PrimaryButton(
                  text: Strings.scanPrinters,
                  radius: 12,
                  height: 46,
                  isLoading: printerState.isScanning,
                  onPressed: printerNotifier.rescanPrinters,
                ),
                12.verticalSpace,
                if (printerState.availablePrinters.isEmpty &&
                    !printerState.isScanning)
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    child: Text(
                      Strings.pairedPrinterHint,
                      style: FontPalette.base500(
                        13,
                        color: colors.secondaryText,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  )
                else
                  Flexible(
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: printerState.availablePrinters.length,
                      separatorBuilder: (_, __) => 10.verticalSpace,
                      itemBuilder: (context, index) {
                        final printer = printerState.availablePrinters[index];
                        final isSelected =
                            printerState.connectedPrinter?.address ==
                            printer.address;
                        return CommonContainer(
                          padding: EdgeInsets.all(14.r),
                          borderRadius: 14.r,
                          color: isSelected
                              ? colors.primary.withValues(alpha: 0.08)
                              : colors.inputBackground,
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      printer.displayName,
                                      style: FontPalette.base700(
                                        13,
                                        color: colors.primaryText,
                                      ),
                                    ),
                                    4.verticalSpace,
                                    Text(
                                      printer.address,
                                      style: FontPalette.base400(
                                        11,
                                        color: colors.secondaryText,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              10.horizontalSpace,
                              PrimaryButton(
                                text: isSelected
                                    ? Strings.printerConnected
                                    : Strings.printBill,
                                radius: 10,
                                height: 38,
                                isLoading: printerState.isConnecting,
                                onPressed: isSelected
                                    ? null
                                    : () => printerNotifier.connectPrinter(
                                          printer,
                                        ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showLogoutConfirmation(BuildContext context, WidgetRef ref) {
    CommonDialogBox.show(
      context: context,
      title: 'Confirm Logout',
      message:
          'Are you sure you want to log out? All local session data will be cleared.',
      primaryLabel: 'Logout',
      secondaryLabel: 'Cancel',
      onPrimary: () {
        ref.read(authProvider.notifier).logout();
      },
    );
  }
}

class _WorkingHourPickerField extends StatelessWidget {
  const _WorkingHourPickerField({
    required this.title,
    required this.valueText,
    required this.hintText,
    required this.onTap,
  });

  final String title;
  final String valueText;
  final String hintText;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: FontPalette.base600(13, color: colors.primaryText),
        ),
        8.verticalSpace,
        CommonContainer(
          onTap: onTap,
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
          borderRadius: 12.r,
          border: Border.all(color: colors.inputBorder, width: 1.w),
          color: colors.inputBackground,
          child: Row(
            children: [
              Expanded(
                child: Text(
                  valueText.isNotEmpty ? valueText : hintText,
                  style: FontPalette.base500(
                    14,
                    color: valueText.isNotEmpty
                        ? colors.primaryText
                        : colors.secondaryText,
                  ),
                ),
              ),
              Icon(
                Icons.access_time_rounded,
                size: 18.r,
                color: colors.secondaryText,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
