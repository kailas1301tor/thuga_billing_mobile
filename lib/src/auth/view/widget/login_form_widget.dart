// lib/src/auth/view/widget/login_form_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vyapapp/res/constants/string_constants.dart';
import 'package:vyapapp/res/enums/enums.dart';
import 'package:vyapapp/res/styles/color_palette.dart';
import 'package:vyapapp/res/styles/font_palette.dart';
import 'package:vyapapp/utils/common_widgets/common_field_section.dart';
import 'package:vyapapp/utils/common_widgets/common_password_field.dart';
import 'package:vyapapp/utils/common_widgets/common_text_form_field.dart';
import 'package:vyapapp/utils/common_widgets/primary_button.dart';
import '../../notifier/auth_notifier.dart';

class LoginFormWidget extends ConsumerWidget {
  const LoginFormWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(authNotifierProvider.notifier);
    final colors = context.appColors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Consumer(
          builder: (context, ref, _) {
            final emailErrorText = ref.watch(
              authNotifierProvider.select((s) => s.emailErrorText),
            );
            return CommonFieldSection(
              title: Strings.email,
              errorText: emailErrorText,
              child: CommonTextFormField(
                controller: notifier.emailController,
                hintText: 'Enter your email address',
                inputType: TextInputType.emailAddress,
                showErrorText: false,
                filledColor: colors.surface,
                borderRadius: 14,
                onChanged: (_) {
                  if (emailErrorText != null) {
                    notifier.clearErrors();
                  }
                },
              ),
            );
          },
        ),
        28.verticalSpace,
        Consumer(
          builder: (context, ref, _) {
            final passwordErrorText = ref.watch(
              authNotifierProvider.select((s) => s.passwordErrorText),
            );
            return CommonFieldSection(
              title: Strings.password,
              trailing: TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  Strings.forgotPassword,
                  style: FontPalette.base600(13, color: colors.primary),
                ),
              ),
              errorText: passwordErrorText,
              child: CommonPasswordField(
                controller: notifier.passwordController,
                hintText: Strings.enterYourPassword,
                errorText: null,
                filledColor: colors.surface,
                borderRadius: 14,
                onChanged: (_) {
                  if (passwordErrorText != null) {
                    notifier.clearPasswordError();
                  }
                },
              ),
            );
          },
        ),
        32.verticalSpace,
        Consumer(
          builder: (context, ref, _) {
            final isLoading = ref.watch(
              authNotifierProvider.select(
                (s) => s.loaderState == LoaderState.loading,
              ),
            );
            return PrimaryButton(
              text: Strings.login,
              isLoading: isLoading,
              onPressed: isLoading
                  ? null
                  : () => notifier.login(),
            );
          },
        ),
      ],
    );
  }
}
