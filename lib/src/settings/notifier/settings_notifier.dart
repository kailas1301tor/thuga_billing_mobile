// lib/src/settings/notifier/settings_notifier.dart
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vyapapp/res/enums/enums.dart';
import 'package:vyapapp/services/repo_di.dart';
import 'package:vyapapp/services/token_service.dart';
import 'package:vyapapp/utils/helpers/toast_helper.dart';
import 'package:vyapapp/utils/helpers/working_hour_helper.dart';
import '../model/settings_model.dart';
import '../model/company_details_model.dart';
import '../state/settings_state.dart';

part 'settings_notifier.g.dart';

@Riverpod(keepAlive: false)
class SettingsNotifier extends _$SettingsNotifier {
  late final TextEditingController storeNameController;
  late final TextEditingController emailController;
  late final TextEditingController taxController;
  late final TextEditingController addressController;
  late final TextEditingController phoneController;
  late final TextEditingController passwordController;

  @override
  SettingsState build() {
    storeNameController = TextEditingController();
    emailController = TextEditingController();
    taxController = TextEditingController();
    addressController = TextEditingController();
    phoneController = TextEditingController();
    passwordController = TextEditingController();

    ref.onDispose(() {
      storeNameController.dispose();
      emailController.dispose();
      taxController.dispose();
      addressController.dispose();
      phoneController.dispose();
      passwordController.dispose();
    });

    Future.microtask(() => fetchSettings());

    return const SettingsState(
      settings: SettingsModel(
        storeName: '',
        email: '',
        autoPrint: false,
        defaultPaymentMethod: 'Cash',
        taxRate: 0.0,
      ),
    );
  }

  void setStartWorkingTime(TimeOfDay time) {
    state = state.copyWith(startWorkingTime: time);
  }

  void setEndWorkingTime(TimeOfDay time) {
    state = state.copyWith(endWorkingTime: time);
  }

  Future<void> fetchSettings() async {
    state = state.copyWith(loaderState: LoaderState.loading);

    // 1. Fetch Local Preferences
    final localResult = await ref.read(settingsRepositoryProvider).getSettings();

    // 2. Fetch Remote Company Details
    final userIdStr = await ref.read(tokenServiceProvider).getUserId();
    final userId = int.tryParse(userIdStr ?? '') ?? 1;
    final remoteResult = await ref.read(settingsRepositoryProvider).getCompanyDetails(userId);

    localResult.fold(
      (left) => state = state.copyWith(
        loaderState: LoaderState.error,
        errorMessage: left.message,
      ),
      (localSettings) {
        remoteResult.fold(
          (left) => state = state.copyWith(
            loaderState: LoaderState.error,
            errorMessage: left.message,
          ),
          (companyDetails) {
            // Populate inputs
            storeNameController.text = companyDetails.companyName;
            emailController.text = companyDetails.email;
            addressController.text = companyDetails.address;
            phoneController.text = companyDetails.phoneNumber;
            passwordController.text = '';
            taxController.text = localSettings.taxRate.toStringAsFixed(0);

            final startTime = resolveWorkingTime(
              companyDetails.startWorkingHour,
              defaultStartWorkingTime,
            );
            final endTime = resolveWorkingTime(
              companyDetails.endWorkingHour,
              defaultEndWorkingTime,
            );

            state = state.copyWith(
              loaderState: LoaderState.loaded,
              settings: localSettings.copyWith(
                storeName: companyDetails.companyName,
                email: companyDetails.email,
              ),
              companyDetails: companyDetails,
              startWorkingTime: startTime,
              endWorkingTime: endTime,
            );
          },
        );
      },
    );
  }

  Future<void> savePreferences() async {
    final name = storeNameController.text.trim();
    final email = emailController.text.trim();
    final address = addressController.text.trim();
    final phone = phoneController.text.trim();
    final password = passwordController.text;
    final tax = double.tryParse(taxController.text.trim()) ?? 0.0;
    final startWorkingHour = formatWorkingHour24(state.startWorkingTime);
    final endWorkingHour = formatWorkingHour24(state.endWorkingTime);

    if (name.isEmpty) {
      showCustomErrorToast(message: 'Store name cannot be empty');
      return;
    }
    if (email.isEmpty || !email.contains('@')) {
      showCustomErrorToast(message: 'Please enter a valid email address');
      return;
    }
    if (address.isEmpty) {
      showCustomErrorToast(message: 'Address cannot be empty');
      return;
    }
    if (phone.isEmpty) {
      showCustomErrorToast(message: 'Phone number cannot be empty');
      return;
    }

    state = state.copyWith(loaderState: LoaderState.loading);

    final userIdStr = await ref.read(tokenServiceProvider).getUserId();
    final userId = int.tryParse(userIdStr ?? '') ?? 1;

    // 1. Update remote company details
    final updateResult = await ref.read(settingsRepositoryProvider).updateCompanyDetails(
      companyId: userId,
      email: email,
      password: password,
      companyName: name,
      address: address,
      phoneNumber: phone,
      startWorkingHour: startWorkingHour,
      endWorkingHour: endWorkingHour,
    );

    updateResult.fold(
      (left) {
        state = state.copyWith(loaderState: LoaderState.error);
        showCustomErrorToast(message: left.message ?? 'Failed to update remote company details');
      },
      (success) async {
        // 2. Save local preferences
        final updatedLocal = state.settings.copyWith(
          storeName: name,
          email: email,
          taxRate: tax,
        );
        await ref.read(settingsRepositoryProvider).saveSettings(updatedLocal);

        state = state.copyWith(
          loaderState: LoaderState.loaded,
          settings: updatedLocal,
          companyDetails: CompanyDetailsModel(
            id: userId,
            companyName: name,
            status: state.companyDetails?.status ?? 'Active',
            address: address,
            phoneNumber: phone,
            isActive: state.companyDetails?.isActive ?? true,
            email: email,
            startWorkingHour: startWorkingHour,
            endWorkingHour: endWorkingHour,
          ),
        );
        showCustomToast(message: 'Company details and settings saved successfully!');
      },
    );
  }

  Future<void> updateAutoPrint(bool val) async {
    final updated = state.settings.copyWith(autoPrint: val);
    state = state.copyWith(settings: updated);
    await ref.read(settingsRepositoryProvider).saveSettings(updated);
  }

  Future<void> updateDefaultPayment(String method) async {
    final updated = state.settings.copyWith(defaultPaymentMethod: method);
    state = state.copyWith(settings: updated);
    await ref.read(settingsRepositoryProvider).saveSettings(updated);
  }

  Future<void> resetToDefaults() async {
    final defaults = const SettingsModel(
      storeName: 'Thuka',
      email: 'contact@thuka.com',
      autoPrint: false,
      defaultPaymentMethod: 'Cash',
      taxRate: 5.0,
    );

    state = state.copyWith(loaderState: LoaderState.loading);
    final result = await ref.read(settingsRepositoryProvider).saveSettings(defaults);

    result.fold(
      (left) {
        state = state.copyWith(
          loaderState: LoaderState.error,
          errorMessage: left.message,
        );
      },
      (right) {
        storeNameController.text = right.storeName;
        emailController.text = right.email;
        addressController.text = 'thrissur';
        phoneController.text = '9987654656';
        passwordController.text = '';
        taxController.text = right.taxRate.toStringAsFixed(0);

        state = state.copyWith(
          loaderState: LoaderState.loaded,
          settings: right,
          startWorkingTime: defaultStartWorkingTime,
          endWorkingTime: defaultEndWorkingTime,
          companyDetails: CompanyDetailsModel(
            id: state.companyDetails?.id ?? 1,
            companyName: right.storeName,
            status: 'Active',
            address: 'thrissur',
            phoneNumber: '9987654656',
            isActive: true,
            email: right.email,
            startWorkingHour: formatWorkingHour24(defaultStartWorkingTime),
            endWorkingHour: formatWorkingHour24(defaultEndWorkingTime),
          ),
        );
        showCustomToast(message: 'Settings reset to defaults');
      },
    );
  }
}
