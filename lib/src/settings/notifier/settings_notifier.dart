// lib/src/settings/notifier/settings_notifier.dart
import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:thuga/res/constants/string_constants.dart';
import 'package:thuga/res/enums/enums.dart';
import 'package:thuga/services/repo_di.dart';
import 'package:thuga/services/token_service.dart';
import 'package:thuga/utils/helpers/file_picker.dart';
import 'package:thuga/utils/helpers/payment_qr_helper.dart';
import 'package:thuga/utils/helpers/toast_helper.dart';
import 'package:thuga/utils/helpers/working_hour_helper.dart';
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

  Future<void> pickPaymentQr() async {
    try {
      final file = await FileSelectionService.instance.pickImage();
      if (file == null) return;
      if (!isAllowedPaymentQrExtension(file.path)) {
        showCustomErrorToast(message: Strings.paymentQrUnsupportedType);
        return;
      }
      state = state.copyWith(selectedQrPath: file.path);
    } catch (e) {
      debugPrint('🔴 Error picking payment QR: $e');
      showCustomErrorToast(message: Strings.paymentQrUnsupportedType);
    }
  }

  void clearSelectedPaymentQr() {
    state = state.copyWith(selectedQrPath: null);
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
              selectedQrPath: null,
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
      showCustomErrorToast(message: Strings.storeNameEmpty);
      return;
    }
    if (email.isEmpty || !email.contains('@')) {
      showCustomErrorToast(message: Strings.invalidEmail);
      return;
    }
    if (address.isEmpty) {
      showCustomErrorToast(message: Strings.addressEmpty);
      return;
    }
    if (phone.isEmpty) {
      showCustomErrorToast(message: Strings.phoneEmpty);
      return;
    }

    state = state.copyWith(loaderState: LoaderState.loading);

    final userIdStr = await ref.read(tokenServiceProvider).getUserId();
    final userId = int.tryParse(userIdStr ?? '') ?? 1;

    final map = <String, dynamic>{
      'id': userId,
      'email': email,
      'company_name': name,
      'address': address,
      'phone_number': phone,
      'start_working_hour': startWorkingHour,
      'end_working_hour': endWorkingHour,
    };
    if (password.isNotEmpty) {
      map['password'] = password;
    }

    final path = state.selectedQrPath;
    if (path != null) {
      map['qr_code'] = await MultipartFile.fromFile(
        path,
        filename: path.split('/').last,
      );
    }
    final formData = FormData.fromMap(map);

    return await ref
        .read(settingsRepositoryProvider)
        .updateCompanyDetails(formData)
        .fold(
          (left) {
            debugPrint('🔴 API ERROR saving company details: ${left.message}');
            state = state.copyWith(loaderState: LoaderState.error);
            showCustomErrorToast(
              message: left.message ?? Strings.companyDetailsSaveFailed,
            );
          },
          (success) async {
            final updatedLocal = state.settings.copyWith(
              storeName: name,
              email: email,
              taxRate: tax,
            );
            await ref.read(settingsRepositoryProvider).saveSettings(updatedLocal);

            final remote = await ref
                .read(settingsRepositoryProvider)
                .getCompanyDetails(userId);

            remote.fold(
              (left) {
                debugPrint(
                  '🔴 API ERROR re-fetching company details: ${left.message}',
                );
                state = state.copyWith(
                  loaderState: LoaderState.loaded,
                  settings: updatedLocal,
                  selectedQrPath: null,
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
                    qrCode: state.companyDetails?.qrCode,
                  ),
                );
                showCustomToast(message: Strings.companyDetailsSavedSuccess);
              },
              (companyDetails) {
                state = state.copyWith(
                  loaderState: LoaderState.loaded,
                  settings: updatedLocal,
                  companyDetails: companyDetails,
                  selectedQrPath: null,
                );
                showCustomToast(message: Strings.companyDetailsSavedSuccess);
              },
            );
          },
        )
        .catchError((e) {
          debugPrint('🔴 UNEXPECTED ERROR saving company details: $e');
          state = state.copyWith(loaderState: LoaderState.error);
          showCustomErrorToast(message: Strings.companyDetailsSaveFailed);
        });
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
    final defaults = SettingsModel(
      storeName: Strings.appName,
      email: 'contact@thuga.com',
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
          selectedQrPath: null,
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
            qrCode: state.companyDetails?.qrCode,
          ),
        );
        showCustomToast(message: Strings.settingsResetSuccess);
      },
    );
  }
}
