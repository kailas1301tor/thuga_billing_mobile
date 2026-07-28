// lib/src/auth/view/register_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thuga/res/constants/string_constants.dart';
import 'package:thuga/res/enums/enums.dart';
import 'package:thuga/res/styles/color_palette.dart';
import 'package:thuga/res/styles/font_palette.dart';
import 'package:thuga/utils/common_widgets/common_app_bar.dart';
import 'package:thuga/utils/common_widgets/common_field_section.dart';
import 'package:thuga/utils/common_widgets/common_password_field.dart';
import 'package:thuga/utils/common_widgets/common_scaffold.dart';
import 'package:thuga/utils/common_widgets/common_text_form_field.dart';
import 'package:thuga/utils/common_widgets/primary_button.dart';
import '../notifier/auth_notifier.dart';

class RegisterScreen extends ConsumerWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(authProvider.notifier);
    final colors = context.appColors;

    return CommonScaffold(
      backgroundColor: colors.background,
      appBar: const CommonAppBar(
        title: 'Register Company',
        showBackButton: true,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight - kToolbarHeight - MediaQuery.of(context).padding.top),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Create Company Profile',
                        style: FontPalette.base700(24, color: colors.primaryText),
                      ),
                      8.verticalSpace,
                      Text(
                        'Set up your business profile to get started.',
                        style: FontPalette.base400(14, color: colors.secondaryText),
                      ),
                      32.verticalSpace,

                      // Company Name Field
                      Consumer(
                        builder: (context, ref, _) {
                          final errorText = ref.watch(
                            authProvider.select((s) => s.companyNameErrorText),
                          );
                          return CommonFieldSection(
                            title: 'Company Name',
                            errorText: errorText,
                            child: CommonTextFormField(
                              controller: notifier.companyNameController,
                              hintText: 'Enter company name',
                              inputType: TextInputType.text,
                              showErrorText: false,
                              filledColor: colors.surface,
                              borderRadius: 14,
                              onChanged: (_) {
                                if (errorText != null) {
                                  notifier.clearCompanyNameError();
                                }
                              },
                            ),
                          );
                        },
                      ),
                      20.verticalSpace,

                      // Email Field
                      Consumer(
                        builder: (context, ref, _) {
                          final errorText = ref.watch(
                            authProvider.select((s) => s.emailErrorText),
                          );
                          return CommonFieldSection(
                            title: Strings.email,
                            errorText: errorText,
                            child: CommonTextFormField(
                              controller: notifier.emailController,
                              hintText: 'Enter email address',
                              inputType: TextInputType.emailAddress,
                              showErrorText: false,
                              filledColor: colors.surface,
                              borderRadius: 14,
                              onChanged: (_) {
                                if (errorText != null) {
                                  notifier.clearEmailError();
                                }
                              },
                            ),
                          );
                        },
                      ),
                      20.verticalSpace,

                      // Password Field
                      Consumer(
                        builder: (context, ref, _) {
                          final errorText = ref.watch(
                            authProvider.select((s) => s.passwordErrorText),
                          );
                          return CommonFieldSection(
                            title: Strings.password,
                            errorText: errorText,
                            child: CommonPasswordField(
                              controller: notifier.passwordController,
                              hintText: 'Enter password',
                              errorText: null,
                              filledColor: colors.surface,
                              borderRadius: 14,
                              onChanged: (_) {
                                if (errorText != null) {
                                  notifier.clearPasswordError();
                                }
                              },
                            ),
                          );
                        },
                      ),
                      20.verticalSpace,

                      // Address Field
                      Consumer(
                        builder: (context, ref, _) {
                          final errorText = ref.watch(
                            authProvider.select((s) => s.addressErrorText),
                          );
                          return CommonFieldSection(
                            title: 'Address',
                            errorText: errorText,
                            child: CommonTextFormField(
                              controller: notifier.addressController,
                              hintText: 'Enter company address',
                              inputType: TextInputType.text,
                              showErrorText: false,
                              filledColor: colors.surface,
                              borderRadius: 14,
                              onChanged: (_) {
                                if (errorText != null) {
                                  notifier.clearAddressError();
                                }
                              },
                            ),
                          );
                        },
                      ),
                      20.verticalSpace,

                      // Phone Field
                      Consumer(
                        builder: (context, ref, _) {
                          final errorText = ref.watch(
                            authProvider.select((s) => s.phoneErrorText),
                          );
                          return CommonFieldSection(
                            title: 'Contact Phone',
                            errorText: errorText,
                            child: CommonTextFormField(
                              controller: notifier.phoneController,
                              hintText: 'Enter contact phone number',
                              inputType: TextInputType.phone,
                              showErrorText: false,
                              filledColor: colors.surface,
                              borderRadius: 14,
                              onChanged: (_) {
                                if (errorText != null) {
                                  notifier.clearPhoneError();
                                }
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 32.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Consumer(
                          builder: (context, ref, _) {
                            final isLoading = ref.watch(
                              authProvider.select(
                                (s) => s.loaderState == LoaderState.loading,
                              ),
                            );
                            return PrimaryButton(
                              text: 'Register',
                              isLoading: isLoading,
                              onPressed: isLoading ? null : () => notifier.register(),
                            );
                          },
                        ),
                        24.verticalSpace,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Already have an account? ',
                              style: FontPalette.base400(14, color: colors.secondaryText),
                            ),
                            GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: Text(
                                Strings.login,
                                style: FontPalette.base700(14, color: colors.primary),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
