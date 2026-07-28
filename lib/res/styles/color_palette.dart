import 'package:flutter/material.dart';

class ColorPalette {
  // Thuka POS brand — Emerald Mint primary
  static const primaryColor = Color(0xFF05B064);
  static const primaryColorDark = Color(0xFF039151);
  static const accentIndigo = Color(0xFF05B064);
  static const secondaryColor = Color(0xFF047844);
  static const navInactive = Color(0xFF9CA3AF);
  static const navBorder = Color(0xFFE5E7EB);

  // Home dashboard tints
  static const homeStatGreenBg = Color(0xFFE6F7ED);
  static const homeStatOrangeBg = Color(0xFFFFF7ED);
  static const homeStatPurpleBg = Color(0xFFF3E8FF);
  static const homeActionGreenBg = Color(0xFFE6F7ED);
  static const homeActionBlueBg = Color(0xFFEFF6FF);
  static const homeActionPurpleBg = Color(0xFFF5F3FF);
  static const homeOrangeAccent = Color(0xFFF97316);
  static const homePurpleAccent = Color(0xFF9333EA);
  static const homeBlueAccent = Color(0xFF3B82F6);
  static const homeYellowAccent = Color(0xFFEAB308);
  static const homePaidBadgeBg = Color(0xFFE6F7ED);
  static const homePaidBadgeBorder = Color(0xFF05B064);
  static const homeOpenPillBg = Color(0xFFE6F7ED);

  static const formValidationErrorColor = Color(0xFFFF453A);
  static const successColor = Color(0xFF34C759);
  static const warningColor = Color(0xFFFF9F0A);

  static const primaryGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [primaryColor, primaryColorDark],
  );

  // Basic colors
  static const transparent = Colors.transparent;
  static const black = Colors.black;
  static const white = Colors.white;
  static const grey = Colors.grey;

  // Custom colors
  static const f191B1E = Color(0xFF191B1E);
  static const fF1F1F1 = Color(0xFFF1F1F1);
  static const f6D6D6D = Color(0xFF6D6D6D);
  static const fE7E7E7 = Color(0xFFE7E7E7);
  static const fD1D1D1 = Color(0xFFD1D1D1);
  static const f4F4F4F = Color(0xFF4F4F4F);
  static const fF6F6F6 = Color(0xFFF6F6F6);
  static const fF4F4F4 = Color(0xFFF4F4F4);
  static const fD9D9D9 = Color(0xFFD9D9D9);
  static const f888888 = Color(0xFF888888);
  static const fF0F0F0 = Color(0xFFF0F0F0);
  static const fEAEAEA = Color(0xFFEAEAEA);
  static const fFBFBFB = Color(0xFFFBFBFB);
  static const f444444 = Color(0xFF444444);
  static const f10000 = Color(0xFFF10000);
  static const f787878 = Color(0xFF787878);
  static const f3D3D3D = Color(0xFF3D3D3D);
  static const f9A1D20 = Color(0xFF9A1D20);
  static const f753401 = Color(0xFF753401);
  static const f656565 = Color(0xFF656565);
  static const f009E35 = Color(0xFF009E35);
  static const fF19121 = Color(0xFFF19121);
  static const f585858 = Color(0xFF585858);
  static const fFF6161 = Color(0xFFFF6161);
  static const f00AF63 = Color(0xFF00AF63);
  static const f674011 = Color(0xFF674011);
  static const f7C6225 = Color(0xFF7C6225);
  static const fE53B40 = Color(0xFFE53B40);
  static const red = Colors.red;
  static const f707070 = Color(0xFF707070);
  static const f0E0F0C = Color(0xFF0E0F0C);
  static const f808080 = Color(0xFF808080);
  static const f5A5A5A = Color(0xFF5A5A5A);
  static const f13AC00 = Color(0xFF13AC00);
  static const fFF9500 = Color(0xFFFF9500);
  static const f80011F = Color(0xFF80011F);
  static const f111113 = Color(0xFF111113);
  static const f292929 = Color(0xFF292929);
  static const fC88C00 = Color(0xFFC88C00);
  static const fA8A8A8 = Color(0xFFA8A8A8);
  static const f050E13 = Color(0xFF050E13);
  static const f544016 = Color(0xFF544016);
  static const fFFEACC = Color(0xFFFFEACC);
  static const f844800 = Color(0xFF844800);
  static const fCA8E00 = Color(0xFFCA8E00);
  static const fF10000 = Color(0xFFF10000);
  static const f22A06D = Color(0xFF22A06D);
  static const f2DBB7E = Color(0xFF2DBB7E);
  static const f787879 = Color(0xFF787879);
  static const fBFBFBF = Color(0xFFBFBFBF);

  // Legacy gym branding (retained for backward compatibility)
  static const neonLime = Color(0xFFD7FF00);
  static const deepLime = Color(0xFFA5C500);
  static const softLime = Color(0xFFE9FF66);
}

/// ThemeExtension to support dynamic color switching between Light and Dark mode
/// for custom branded colors that fall outside standard Material semantic colors.
class AppColors extends ThemeExtension<AppColors> {
  final Color primaryText;
  final Color secondaryText;
  final Color background;
  final Color authBackground;
  final Color surface;
  final Color errorText;
  final Color inputBorder;
  final Color inputBackground;
  final Color primary;
  final Color primaryDark;
  final Color secondary;
  final Color accent;

  const AppColors({
    required this.primaryText,
    required this.secondaryText,
    required this.background,
    required this.authBackground,
    required this.surface,
    required this.errorText,
    required this.inputBorder,
    required this.inputBackground,
    required this.primary,
    required this.primaryDark,
    required this.secondary,
    required this.accent,
  });

  LinearGradient get primaryGradient => LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [primary, primaryDark],
  );

  @override
  AppColors copyWith({
    Color? primaryText,
    Color? secondaryText,
    Color? background,
    Color? authBackground,
    Color? surface,
    Color? errorText,
    Color? inputBorder,
    Color? inputBackground,
    Color? primary,
    Color? primaryDark,
    Color? secondary,
    Color? accent,
  }) {
    return AppColors(
      primaryText: primaryText ?? this.primaryText,
      secondaryText: secondaryText ?? this.secondaryText,
      background: background ?? this.background,
      authBackground: authBackground ?? this.authBackground,
      surface: surface ?? this.surface,
      errorText: errorText ?? this.errorText,
      inputBorder: inputBorder ?? this.inputBorder,
      inputBackground: inputBackground ?? this.inputBackground,
      primary: primary ?? this.primary,
      primaryDark: primaryDark ?? this.primaryDark,
      secondary: secondary ?? this.secondary,
      accent: accent ?? this.accent,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) {
      return this;
    }
    return AppColors(
      primaryText: Color.lerp(primaryText, other.primaryText, t)!,
      secondaryText: Color.lerp(secondaryText, other.secondaryText, t)!,
      background: Color.lerp(background, other.background, t)!,
      authBackground: Color.lerp(authBackground, other.authBackground, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      errorText: Color.lerp(errorText, other.errorText, t)!,
      inputBorder: Color.lerp(inputBorder, other.inputBorder, t)!,
      inputBackground: Color.lerp(inputBackground, other.inputBackground, t)!,
      primary: Color.lerp(primary, other.primary, t)!,
      primaryDark: Color.lerp(primaryDark, other.primaryDark, t)!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
      accent: Color.lerp(accent, other.accent, t)!,
    );
  }

  /// Preset for Light Mode — Thuka POS aesthetics
  static const AppColors light = AppColors(
    primaryText: Color(0xFF111827),
    secondaryText: Color(0xFF6B7280),
    background: Color(0xFFFFFFFF),
    authBackground: Color(0xFFE6F7ED),
    surface: ColorPalette.white,
    errorText: ColorPalette.formValidationErrorColor,
    inputBorder: Color(0xFFE5E7EB),
    inputBackground: Color(0xFFF9FAFB),
    primary: ColorPalette.primaryColor,
    primaryDark: ColorPalette.primaryColorDark,
    secondary: ColorPalette.secondaryColor,
    accent: ColorPalette.primaryColor,
  );

  /// Preset for Dark Mode
  static const AppColors dark = AppColors(
    primaryText: Color(0xFFF5F5F7),
    secondaryText: Color(0xFF86868B),
    background: Color(0xFF0A0B0F),
    authBackground: Color(0xFF12131A),
    surface: Color(0xFF16171D),
    errorText: Color(0xFFFF6961),
    inputBorder: Color(0xFF2C2C2E),
    inputBackground: Color(0xFF1C1C1E),
    primary: ColorPalette.primaryColor,
    primaryDark: ColorPalette.primaryColorDark,
    secondary: ColorPalette.secondaryColor,
    accent: ColorPalette.primaryColor,
  );
}

extension AppContext on BuildContext {
  AppColors get appColors => Theme.of(this).extension<AppColors>()!;
}
