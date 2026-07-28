// lib/src/auth/view/web/register_web_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:thuga/res/constants/string_constants.dart';
import 'package:thuga/res/enums/enums.dart';
import 'package:thuga/res/styles/color_palette.dart';
import 'package:thuga/res/styles/font_palette.dart';
import 'package:thuga/res/styles/web_spacing.dart';
import 'package:thuga/utils/common_widgets/common_field_section.dart';
import 'package:thuga/utils/common_widgets/common_password_field.dart';
import 'package:thuga/utils/common_widgets/common_text_form_field.dart';
import 'package:thuga/utils/common_widgets/primary_button.dart';
import 'package:thuga/utils/common_widgets/thuga_logo.dart';

import '../../notifier/auth_notifier.dart';

class RegisterWebScreen extends ConsumerWidget {
  const RegisterWebScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(authProvider.notifier);
    final colors = context.appColors;

    return Scaffold(
      backgroundColor: colors.background,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(WebSpacing.pagePadding),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight - WebSpacing.pagePadding * 2,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 560),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: colors.surface,
                      borderRadius:
                          BorderRadius.circular(WebSpacing.cardRadius),
                      border: Border.all(color: colors.inputBorder),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(WebSpacing.xl),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                    const Center(child: ThugaLogo(size: 64)),
                    const SizedBox(height: WebSpacing.lg),
                    Text(
                      'Create Company Profile',
                      style: FontPalette.base700(24, color: colors.primaryText),
                    ),
                    const SizedBox(height: WebSpacing.sm),
                    Text(
                      'Set up your business profile to get started.',
                      style: FontPalette.base400(14, color: colors.secondaryText),
                    ),
                    const SizedBox(height: WebSpacing.xl),
                    CommonFieldSection(
                      title: 'Company Name',
                      child: CommonTextFormField(
                        controller: notifier.companyNameController,
                        hintText: 'Enter company name',
                        filledColor: colors.surface,
                        borderRadius: 14,
                      ),
                    ),
                    const SizedBox(height: WebSpacing.md),
                    CommonFieldSection(
                      title: Strings.email,
                      child: CommonTextFormField(
                        controller: notifier.emailController,
                        hintText: 'Enter email address',
                        inputType: TextInputType.emailAddress,
                        filledColor: colors.surface,
                        borderRadius: 14,
                      ),
                    ),
                    const SizedBox(height: WebSpacing.md),
                    CommonFieldSection(
                      title: Strings.password,
                      child: CommonPasswordField(
                        controller: notifier.passwordController,
                        hintText: 'Enter password',
                        filledColor: colors.surface,
                        borderRadius: 14,
                      ),
                    ),
                    const SizedBox(height: WebSpacing.xl),
                    Consumer(
                      builder: (context, ref, _) {
                        final isLoading = ref.watch(
                          authProvider.select(
                            (s) => s.loaderState == LoaderState.loading,
                          ),
                        );
                        return PrimaryButton(
                          text: Strings.register,
                          isLoading: isLoading,
                          onPressed: isLoading ? null : notifier.register,
                        );
                      },
                    ),
                    const SizedBox(height: WebSpacing.lg),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account? ',
                          style: FontPalette.base400(
                            14,
                            color: colors.secondaryText,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => context.pop(),
                          child: Text(
                            Strings.login,
                            style: FontPalette.base700(
                              14,
                              color: colors.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
