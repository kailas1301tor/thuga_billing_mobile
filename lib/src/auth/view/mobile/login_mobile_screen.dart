// lib/src/auth/view/mobile/login_mobile_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thuga/res/styles/color_palette.dart';
import 'package:thuga/utils/common_widgets/common_scaffold.dart';

import '../widget/login_form_widget.dart';

class LoginMobileScreen extends ConsumerWidget {
  const LoginMobileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.appColors;

    return CommonScaffold(
      backgroundColor: colors.background,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [LoginFormWidget()],
              ),
            ),
          );
        },
      ),
    );
  }
}
