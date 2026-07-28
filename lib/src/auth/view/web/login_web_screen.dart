// lib/src/auth/view/web/login_web_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thuga/res/styles/color_palette.dart';
import 'package:thuga/res/styles/web_spacing.dart';
import 'package:thuga/utils/common_widgets/thuga_logo.dart';

import '../widget/login_form_widget.dart';

class LoginWebScreen extends ConsumerWidget {
  const LoginWebScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                  constraints: const BoxConstraints(maxWidth: 440),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Center(child: ThugaLogo(size: 72)),
                      const SizedBox(height: WebSpacing.lg),
                      DecoratedBox(
                        decoration: BoxDecoration(
                          color: colors.surface,
                          borderRadius:
                              BorderRadius.circular(WebSpacing.cardRadius),
                          border: Border.all(color: colors.inputBorder),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(WebSpacing.xl),
                          child: LoginFormWidget(),
                        ),
                      ),
                    ],
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
