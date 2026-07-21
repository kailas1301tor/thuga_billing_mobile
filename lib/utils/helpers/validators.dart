import 'package:vyapapp/res/constants/string_constants.dart';
import 'package:vyapapp/utils/helpers/extensions.dart';

/// Common form validators.
class Validators {
  /// Validate email address.
  static String? validateEmail(String? value) {
    if (value.isNullOrEmpty) return Strings.emailRequired;
    if (!value!.isValidEmail) return Strings.invalidEmail;
    return null;
  }

  /// Validate password.
  static String? validatePassword(String? value) {
    if (value.isNullOrEmpty) return Strings.passwordRequired;
    if (!value!.isValidPassword) return Strings.passwordTooShort;
    return null;
  }

  /// Validate confirm password.
  static String? validateConfirmPassword(String? value, String? password) {
    if (value.isNullOrEmpty) return Strings.passwordRequired;
    if (value != password) return Strings.passwordsDoNotMatch;
    return null;
  }

  /// Validate required field.
  static String? validateRequired(String? value, [String? fieldName]) {
    if (value.isNullOrEmpty) {
      return fieldName == null
          ? Strings.fieldRequired
          : '$fieldName is required';
    }
    return null;
  }

  /// Validate phone number.
  static String? validatePhone(String? value) {
    if (value.isNullOrEmpty) return Strings.invalidPhone;
    if (!value!.isValidPhone) return Strings.invalidPhone;
    return null;
  }

  /// Validate name.
  static String? validateName(String? value) {
    if (value.isNullOrEmpty) return Strings.invalidName;
    if (value!.length < 2) return Strings.invalidName;
    return null;
  }
}

/// Extension on nullable string for easy inline validation.
///
/// Example:
/// ```dart
/// TextFormField(
///   validator: (v) => v.validateEmail,
/// )
/// ```
extension ValidatorExtension on String? {
  String? get validateEmail => Validators.validateEmail(this);
  String? get validatePassword => Validators.validatePassword(this);
  String? validateConfirmPassword(String? password) =>
      Validators.validateConfirmPassword(this, password);
  String? validateRequired([String? fieldName]) =>
      Validators.validateRequired(this, fieldName);
  String? get validatePhone => Validators.validatePhone(this);
  String? get validateName => Validators.validateName(this);
}
