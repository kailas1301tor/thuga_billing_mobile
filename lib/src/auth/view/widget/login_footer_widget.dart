// lib/src/auth/view/widget/login_footer_widget.dart
import 'package:flutter/material.dart';
import 'package:vyapapp/res/constants/string_constants.dart';
import 'package:vyapapp/res/styles/color_palette.dart';
import 'package:vyapapp/res/styles/font_palette.dart';
import 'package:vyapapp/utils/routes/route_constants.dart';

class LoginFooterWidget extends StatelessWidget {
  const LoginFooterWidget({super.key});

  void _onSignUpTap(BuildContext context) {
    Navigator.pushNamed(context, RouteConstants.routeRegisterScreen);
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Text(
        //   Strings.dontHaveAccount,
        //   style: FontPalette.base400(14, color: colors.secondaryText),
        // ),
        // GestureDetector(
        //   onTap: () => _onSignUpTap(context),
        //   child: Text(
        //     Strings.signUp,
        //     style: FontPalette.base700(14, color: colors.primary),
        //   ),
        // ),
      ],
    );
  }
}
