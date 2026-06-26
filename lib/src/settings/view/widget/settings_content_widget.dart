// lib/src/settings/view/widget/settings_content_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vyapapp/res/styles/color_palette.dart';
import 'package:vyapapp/res/styles/font_palette.dart';
import 'package:vyapapp/res/styles/theme_provider.dart';
import 'package:vyapapp/utils/common_widgets/common_container.dart';
import 'package:vyapapp/utils/common_widgets/common_text_form_field.dart';
import 'package:vyapapp/utils/common_widgets/primary_button.dart';
import '../../notifier/settings_notifier.dart';
import '../../model/settings_model.dart';

class SettingsContentWidget extends ConsumerWidget {
  const SettingsContentWidget({
    super.key,
    required this.settings,
  });

  final SettingsModel settings;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.appColors;
    final notifier = ref.read(settingsNotifierProvider.notifier);
    final themeMode = ref.watch(themeNotifierProvider).valueOrNull ?? ThemeMode.system;
    final firstLetter = settings.storeName.isNotEmpty ? settings.storeName.trim()[0].toUpperCase() : 'S';

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Column(
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
                            settings.storeName.isNotEmpty ? settings.storeName : 'My Store',
                            style: FontPalette.base700(16, color: colors.primaryText),
                          ),
                          4.verticalSpace,
                          Text(
                            settings.email.isNotEmpty ? settings.email : 'No email set',
                            style: FontPalette.base400(12, color: colors.secondaryText),
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
              ],
            ),
          ),
          20.verticalSpace,

          // 2. Tax Rate Section
          _buildSectionHeader(context, 'Tax Configuration'),
          12.verticalSpace,
          CommonContainer(
            padding: EdgeInsets.all(16.r),
            borderRadius: 16.r,
            child: CommonTextFormField(
              controller: notifier.taxController,
              title: 'Default Tax Rate',
              hintText: '0',
              inputType: TextInputType.number,
              suffix: Padding(
                padding: EdgeInsets.only(right: 12.w),
                child: Text(
                  '%',
                  style: FontPalette.base700(14, color: colors.secondaryText),
                ),
              ),
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
          24.verticalSpace,

          // 4. Save Button
          PrimaryButton(
            text: 'Save Preferences',
            onPressed: () => notifier.savePreferences(),
            height: 50,
            radius: 12,
          ),
          20.verticalSpace,
        ],
      ),
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

  Widget _buildThemeSelector(BuildContext context, WidgetRef ref, ThemeMode currentMode) {
    final colors = context.appColors;

    Widget buildOption({
      required ThemeMode mode,
      required String label,
      required IconData icon,
    }) {
      final isSelected = currentMode == mode;
      return Expanded(
        child: GestureDetector(
          onTap: () => ref.read(themeNotifierProvider.notifier).setThemeMode(mode),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 12.h),
            decoration: BoxDecoration(
              color: isSelected ? colors.primary.withValues(alpha: 0.08) : colors.inputBackground,
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
}
