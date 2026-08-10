import 'package:either_dart/either.dart';
import 'package:thuga/services/di_services.dart';
import 'package:thuga/services/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:thuga/res/enums/enums.dart';
import 'package:thuga/services/repo_di.dart';
import 'package:thuga/utils/common_widgets/custom_toast.dart';
import 'package:thuga/utils/helpers/api_error_handler.dart';
import 'package:thuga/services/token_service.dart';
import 'package:thuga/utils/routes/app_navigator.dart';
import 'package:thuga/utils/routes/route_constants.dart';
import '../../../utils/helpers/validators.dart';
import '../state/auth_state.dart';
import '../repo/auth_repo.dart';

part 'auth_notifier.g.dart';

@Riverpod(keepAlive: false)
class AuthNotifier extends _$AuthNotifier {
  late final TextEditingController emailController;
  late final TextEditingController phoneController;
  late final TextEditingController passwordController;
  late final TextEditingController companyNameController;
  late final TextEditingController addressController;

  late AuthRepo authRepo;

  @override
  AuthState build() {
    emailController = TextEditingController();
    phoneController = TextEditingController();
    passwordController = TextEditingController();
    companyNameController = TextEditingController();
    addressController = TextEditingController();

    authRepo = ref.read(authRepositoryProvider);

    ref.onDispose(() {
      emailController.dispose();
      phoneController.dispose();
      passwordController.dispose();
      companyNameController.dispose();
      addressController.dispose();
    });

    return const AuthState();
  }

  /// Login with email and password.
  Future<bool> login() async {
    if (!validateLoginFields()) {
      return false;
    }

    state = state.copyWith(loaderState: LoaderState.loading);
    return await authRepo
        .login(
          email: emailController.text.trim(),
          password: passwordController.text,
        )
        .fold(
          (error) {
            final loaderState = handleResponseError(error.key);
            debugPrint("🔴 LOGIN ERROR: ${error.message}");
            state = state.copyWith(loaderState: loaderState);
            showCustomToast(
              message: error.message ?? "Login failed",
              isSuccess: false,
            );
            return false;
          },
          (authModel) async {
            debugPrint('🔍 AUTH MODEL TOKENS:');
            debugPrint('  accessToken: "${authModel.accessToken}"');
            debugPrint('  refreshToken: "${authModel.refreshToken}"');
            debugPrint('  id: ${authModel.id}');
            debugPrint('  email: "${authModel.email}"');

            final accessVal = authModel.accessToken ?? '';
            final refreshVal = authModel.refreshToken ?? '';
            debugPrint(
              '🔍 SAVING TO SEMBAST → access="$accessVal", refresh="$refreshVal"',
            );

            await ref
                .read(tokenServiceProvider)
                .saveTokens(accessToken: accessVal, refreshToken: refreshVal);
            await ref
                .read(tokenServiceProvider)
                .saveUserId(authModel.id.toString());
            await safeCrashlyticsSetUserIdentifier(authModel.id.toString());

            // Verify round-trip
            final readBack = await ref
                .read(tokenServiceProvider)
                .getAccessToken();
            debugPrint('🔍 READ-BACK FROM SEMBAST → "$readBack"');
            debugPrint(
              '🔍 isEmpty=${readBack?.isEmpty}, isNull=${readBack == null}',
            );

            debugPrint("🟢 LOGIN SUCCESS: ${authModel.email}");
            state = state.copyWith(
              loaderState: LoaderState.loaded,
              authModel: authModel,
            );
            navigateAndClearStack(RouteConstants.routeHomeScreen);
            return true;
          },
        )
        .catchError((error) {
          debugPrint("🔴 UNEXPECTED LOGIN ERROR: $error");
          state = state.copyWith(loaderState: LoaderState.error);
          showCustomToast(
            message: "An unexpected error occurred",
            isSuccess: false,
          );
          return false;
        });
  }

  /// Register a new company profile.
  Future<bool> register() async {
    if (!validateRegisterFields()) {
      return false;
    }

    state = state.copyWith(loaderState: LoaderState.loading);

    return authRepo
        .register(
          email: emailController.text.trim(),
          password: passwordController.text,
          companyName: companyNameController.text.trim(),
          address: addressController.text.trim(),
          phoneNumber: phoneController.text.trim(),
        )
        .fold(
          (error) {
            final loaderState = handleResponseError(error.key);
            debugPrint("🔴 REGISTER ERROR: ${error.message}");
            state = state.copyWith(loaderState: loaderState);
            showCustomToast(
              message: error.message ?? "Registration failed",
              isSuccess: false,
            );
            return false;
          },
          (success) {
            debugPrint("🟢 REGISTER SUCCESS: ${success.message}");
            state = state.copyWith(loaderState: LoaderState.loaded);
            showCustomToast(
              message: success.message.isNotEmpty
                  ? success.message
                  : "Registered successfully!",
              isSuccess: true,
            );
            navigateAndClearStack(RouteConstants.routeLoginScreen);
            return true;
          },
        )
        .catchError((error) {
          debugPrint("🔴 UNEXPECTED REGISTER ERROR: $error");
          state = state.copyWith(loaderState: LoaderState.error);
          showCustomToast(
            message: "An unexpected error occurred",
            isSuccess: false,
          );
          return false;
        });
  }

  bool validateLoginFields() {
    final emailError = Validators.validateEmail(emailController.text);
    final passwordError = Validators.validatePassword(passwordController.text);
    state = state.copyWith(
      emailErrorText: emailError,
      passwordErrorText: passwordError,
    );
    return emailError == null && passwordError == null;
  }

  bool validateRegisterFields() {
    final companyNameError = Validators.validateRequired(
      companyNameController.text,
      'Company Name',
    );
    final emailError = Validators.validateEmail(emailController.text);
    final passwordError = Validators.validatePassword(passwordController.text);
    final addressError = Validators.validateRequired(
      addressController.text,
      'Address',
    );
    final phoneError = Validators.validatePhone(phoneController.text);

    state = state.copyWith(
      companyNameErrorText: companyNameError,
      emailErrorText: emailError,
      passwordErrorText: passwordError,
      addressErrorText: addressError,
      phoneErrorText: phoneError,
    );

    return companyNameError == null &&
        emailError == null &&
        passwordError == null &&
        addressError == null &&
        phoneError == null;
  }

  void clearErrors() {
    state = state.copyWith(
      emailErrorText: null,
      passwordErrorText: null,
      phoneErrorText: null,
      companyNameErrorText: null,
      addressErrorText: null,
    );
  }

  void clearAll() {
    emailController.clear();
    passwordController.clear();
    phoneController.clear();
    companyNameController.clear();
    addressController.clear();
    clearErrors();
  }

  void clearPhoneError() {
    state = state.copyWith(phoneErrorText: null);
  }

  void clearPasswordError() {
    state = state.copyWith(passwordErrorText: null);
  }

  void clearCompanyNameError() {
    state = state.copyWith(companyNameErrorText: null);
  }

  void clearAddressError() {
    state = state.copyWith(addressErrorText: null);
  }

  void clearEmailError() {
    state = state.copyWith(emailErrorText: null);
  }

  /// Log out via API, clear local tokens, and redirect to the login screen.
  Future<void> logout() async {
    if (!ref.mounted) return;

    state = state.copyWith(logoutLoader: true);

    final container = ref.container;
    final tokenService = container.read(tokenServiceProvider);

    await authRepo
        .logout()
        .fold(
          (left) {
            debugPrint("🔴 LOGOUT API ERROR: ${left.message}");
          },
          (right) {
            debugPrint("🟢 LOGOUT API SUCCESS: ${right.message}");
          },
        )
        .catchError((e) {
          debugPrint("🔴 UNEXPECTED LOGOUT ERROR: $e");
        });

    await tokenService.clearTokens();
    await safeCrashlyticsSetUserIdentifier('');
    disposeProviders(container);

    if (ref.mounted) {
      state = state.copyWith(logoutLoader: false);
    }

    navigateAndClearStack(RouteConstants.routeLoginScreen);
  }
}
