# Payment UPI QR Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Let owners upload a UPI payment QR via company-details multipart PUT in Settings, and show it on New Bill when payment method is UPI.

**Architecture:** Extend `CompanyDetailsModel` + Settings FormData PUT (product upload pattern). Settings UI picks jpg/jpeg/png. New Bill footer opens a large sheet; `NewBillNotifier.loadPaymentQr()` reads Settings cache if present, else GETs company details.

**Tech Stack:** Flutter, Riverpod code gen, Freezed, Dio FormData/`putMultiPartRequest`, `FileSelectionService`, `CommonCachedNetworkImage`, `CommonBottomSheet`, EN/ML l10n via `Strings.`

**Spec:** [docs/superpowers/specs/2026-09-24-payment-upi-qr-design.md](../specs/2026-09-24-payment-upi-qr-design.md)

## Global Constraints

- Feature layers stay under existing `settings/` and `new_bill/` (no cross-feature imports except `utils/`, `res/`, `data/`, `services/`).
- No hardcoded user-visible strings, colors, or inline `TextStyle` — use `Strings.`, `ColorPalette.`, `FontPalette.`.
- New copy in both `assets/l10n/en.json` and `ml.json`, then `Strings.` getters.
- ScreenUtil: `.h` / `.w` / `.r` / `.verticalSpace` / `.horizontalSpace`.
- Controllers stay in notifiers; UI uses `ref.watch(...select(...))`.
- QR upload types: **jpg, jpeg, png** only; max size `AppConstants.maxImageSizeMb`.
- PUT always multipart FormData; attach `qr_code` MultipartFile only when a new local file was picked.
- Out of scope: delete remote QR, UPI ID generation, bill-preview QR, SharedPreferences URL cache, `/api/v1/user/profile`.

## File map

| File | Responsibility |
|------|----------------|
| `lib/utils/helpers/payment_qr_helper.dart` | Pure helpers: allowed QR extensions, normalize empty URL → null |
| `test/utils/helpers/payment_qr_helper_test.dart` | Unit tests for helpers |
| `test/src/settings/model/company_details_model_test.dart` | `qr_code` JSON parsing |
| `lib/src/settings/model/company_details_model.dart` | Add `qrCode` |
| `lib/src/settings/state/settings_state.dart` | Add `selectedQrPath` |
| `lib/src/settings/repo/settings_repository.dart` | `updateCompanyDetails(FormData)` via `putMultiPartRequest` |
| `lib/src/settings/notifier/settings_notifier.dart` | Pick/clear QR; build FormData; re-fetch after save |
| `lib/src/settings/view/widget/settings_payment_qr_section.dart` | Store Profile QR preview/picker UI |
| `lib/src/settings/view/widget/settings_content_widget.dart` | Embed QR section |
| `lib/src/new_bill/state/new_bill_state.dart` | `paymentQrLoaderState`, `paymentQrUrl` |
| `lib/src/new_bill/notifier/new_bill_notifier.dart` | `loadPaymentQr()` |
| `lib/src/new_bill/view/widget/payment_qr_sheet.dart` | Large sheet UI |
| `lib/src/new_bill/view/widget/new_bill_footer.dart` | Show QR when UPI |
| `assets/l10n/en.json`, `ml.json`, `string_constants.dart` | Copy |

---

### Task 1: Payment QR helpers + model parsing

**Files:**
- Create: `lib/utils/helpers/payment_qr_helper.dart`
- Create: `test/utils/helpers/payment_qr_helper_test.dart`
- Create: `test/src/settings/model/company_details_model_test.dart`
- Modify: `lib/src/settings/model/company_details_model.dart`

**Interfaces:**
- Consumes: `convertToString` from `safe_converters.dart`
- Produces:
  - `bool isAllowedPaymentQrExtension(String path)`
  - `String? normalizeQrCodeUrl(String? raw)` — empty/whitespace → `null`
  - `CompanyDetailsModel.qrCode` (`String?`) from JSON key `qr_code`

- [ ] **Step 1: Write failing helper tests**

```dart
// test/utils/helpers/payment_qr_helper_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:thuga/utils/helpers/payment_qr_helper.dart';

void main() {
  group('isAllowedPaymentQrExtension', () {
    test('allows jpg jpeg png case-insensitive', () {
      expect(isAllowedPaymentQrExtension('/a/b.JPG'), isTrue);
      expect(isAllowedPaymentQrExtension('/a/b.jpeg'), isTrue);
      expect(isAllowedPaymentQrExtension('/a/b.png'), isTrue);
    });

    test('rejects heic webp and missing extension', () {
      expect(isAllowedPaymentQrExtension('/a/b.heic'), isFalse);
      expect(isAllowedPaymentQrExtension('/a/b.webp'), isFalse);
      expect(isAllowedPaymentQrExtension('/a/b'), isFalse);
    });
  });

  group('normalizeQrCodeUrl', () {
    test('null and blank become null', () {
      expect(normalizeQrCodeUrl(null), isNull);
      expect(normalizeQrCodeUrl(''), isNull);
      expect(normalizeQrCodeUrl('   '), isNull);
    });

    test('trims non-empty url', () {
      expect(
        normalizeQrCodeUrl(' https://cdn.example/qr.png '),
        'https://cdn.example/qr.png',
      );
    });
  });
}
```

- [ ] **Step 2: Run helper tests — expect FAIL**

```bash
flutter test test/utils/helpers/payment_qr_helper_test.dart
```

Expected: FAIL (library/functions not found).

- [ ] **Step 3: Implement helpers**

```dart
// lib/utils/helpers/payment_qr_helper.dart
import 'package:path/path.dart' as p;

const allowedPaymentQrExtensions = {'.jpg', '.jpeg', '.png'};

bool isAllowedPaymentQrExtension(String path) {
  final ext = p.extension(path).toLowerCase();
  return allowedPaymentQrExtensions.contains(ext);
}

String? normalizeQrCodeUrl(String? raw) {
  if (raw == null) return null;
  final trimmed = raw.trim();
  if (trimmed.isEmpty) return null;
  return trimmed;
}
```

- [ ] **Step 4: Re-run helper tests — expect PASS**

```bash
flutter test test/utils/helpers/payment_qr_helper_test.dart
```

- [ ] **Step 5: Write failing model tests**

```dart
// test/src/settings/model/company_details_model_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:thuga/src/settings/model/company_details_model.dart';

void main() {
  test('parses qr_code url', () {
    final m = CompanyDetailsModel.fromJson({
      'id': 1,
      'company_name': 'Shop',
      'status': 'Active',
      'address': 'a',
      'phone_number': '1',
      'is_active': true,
      'email': 'a@b.com',
      'qr_code': 'https://cdn.example/qr.png',
    });
    expect(m.qrCode, 'https://cdn.example/qr.png');
  });

  test('null and empty qr_code become null', () {
    expect(
      CompanyDetailsModel.fromJson({
        'id': 1,
        'company_name': 'Shop',
        'status': 'Active',
        'address': 'a',
        'phone_number': '1',
        'is_active': true,
        'email': 'a@b.com',
      }).qrCode,
      isNull,
    );
    expect(
      CompanyDetailsModel.fromJson({
        'id': 1,
        'company_name': 'Shop',
        'status': 'Active',
        'address': 'a',
        'phone_number': '1',
        'is_active': true,
        'email': 'a@b.com',
        'qr_code': '',
      }).qrCode,
      isNull,
    );
  });
}
```

- [ ] **Step 6: Run model tests — expect FAIL**

```bash
flutter test test/src/settings/model/company_details_model_test.dart
```

- [ ] **Step 7: Add `qrCode` to model**

In `CompanyDetailsModel`:
- Field: `final String? qrCode;`
- Constructor optional named `this.qrCode`
- In `fromJson`: `qrCode: normalizeQrCodeUrl(convertToString(json['qr_code']))` (import helper; `convertToString` of null yields `''` → normalize → null)
- Update `_getMockCompany` in settings repo later (Task 2) to pass `qrCode: null`

- [ ] **Step 8: Re-run model tests — expect PASS**

```bash
flutter test test/src/settings/model/company_details_model_test.dart
```

- [ ] **Step 9: Commit**

```bash
git add lib/utils/helpers/payment_qr_helper.dart \
  test/utils/helpers/payment_qr_helper_test.dart \
  lib/src/settings/model/company_details_model.dart \
  test/src/settings/model/company_details_model_test.dart
git commit -m "$(cat <<'EOF'
feat: add payment QR helpers and company qr_code parsing

EOF
)"
```

---

### Task 2: Settings multipart PUT + notifier pick/save

**Files:**
- Modify: `lib/src/settings/state/settings_state.dart`
- Modify: `lib/src/settings/repo/settings_repository.dart`
- Modify: `lib/src/settings/notifier/settings_notifier.dart`
- Modify: `assets/l10n/en.json`, `assets/l10n/ml.json`
- Modify: `lib/res/constants/string_constants.dart`

**Interfaces:**
- Consumes: `CompanyDetailsModel.qrCode`, `isAllowedPaymentQrExtension`, `FileSelectionService.instance.pickImage`, `putMultiPartRequest`
- Produces:
  - `SettingsState.selectedQrPath` (`String?`)
  - `SettingsNotifier.pickPaymentQr()` / `clearSelectedPaymentQr()`
  - `SettingsRepo.updateCompanyDetails({required FormData formData})`
  - After save success: re-fetch company details; clear `selectedQrPath`

- [ ] **Step 1: Add l10n keys (EN + ML) and Strings getters**

EN examples (ML: natural Malayalam equivalents):

```json
"paymentQrSectionTitle": "UPI payment QR",
"paymentQrHint": "Shown when billing with UPI",
"paymentQrAdd": "Add UPI QR",
"paymentQrChange": "Change QR",
"paymentQrClearLocal": "Remove selected",
"paymentQrUnsupportedType": "Use a JPG, JPEG, or PNG image",
"showPaymentQr": "Show QR",
"paymentQrSheetTitle": "Scan to pay",
"paymentQrScanHelper": "Ask the customer to scan this UPI QR",
"paymentQrEmpty": "No UPI QR uploaded. Add one in Settings → Store Profile.",
"paymentQrLoadFailed": "Could not load payment QR"
```

Add matching getters on `Strings`.

- [ ] **Step 2: Add `selectedQrPath` to Freezed state**

```dart
@Default(null) String? selectedQrPath,
```

Run:

```bash
dart run build_runner build --delete-conflicting-outputs
```

- [ ] **Step 3: Change repo update to FormData**

Abstract + impl:

```dart
Future<Either<ResponseError, CommonResponseModel>> updateCompanyDetails(
  FormData formData,
);
```

Impl:

```dart
return await _networkServices
    .safe(
      _networkServices.putMultiPartRequest(
        endPoint: AppConstants.companyDetails,
        formFields: formData,
      ),
    )
    .thenRight(_networkServices.checkHttpStatus)
    .thenRight(_networkServices.parseJson)
    .mapRight((right) => CommonResponseModel.fromJson(right));
```

Update `_getMockCompany` to include `qrCode: null`.

- [ ] **Step 4: Notifier — pick / clear / save with FormData**

```dart
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
```

In `savePreferences`, after validation:

```dart
final map = <String, dynamic>{
  'id': userId,
  'email': email,
  'company_name': name,
  'address': address,
  'phone_number': phone,
  'start_working_hour': startWorkingHour,
  'end_working_hour': endWorkingHour,
};
if (password.isNotEmpty) map['password'] = password;

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
            state = state.copyWith(
              loaderState: LoaderState.loaded,
              settings: updatedLocal,
              selectedQrPath: null,
            );
            showCustomToast(message: Strings.companyDetailsSavedSuccess);
          },
          (companyDetails) {
            // sync controllers already filled; update companyDetails
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
    );
```

Use `.fold` chained on the Future (project style). Prefer rewriting the existing await+fold block to match AGENTS `.fold().catchError()` if touching that path.

When constructing inline `CompanyDetailsModel` elsewhere in this method, include `qrCode: state.companyDetails?.qrCode`.

- [ ] **Step 5: Manual smoke (or analyze)**

```bash
dart analyze lib/src/settings
```

Expected: no errors on changed files.

- [ ] **Step 6: Commit**

```bash
git add lib/src/settings assets/l10n/en.json assets/l10n/ml.json \
  lib/res/constants/string_constants.dart
git commit -m "$(cat <<'EOF'
feat: upload payment QR via company-details multipart PUT

EOF
)"
```

---

### Task 3: Settings Store Profile QR UI

**Files:**
- Create: `lib/src/settings/view/widget/settings_payment_qr_section.dart`
- Modify: `lib/src/settings/view/widget/settings_content_widget.dart`

**Interfaces:**
- Consumes: `settingsProvider.select` for `selectedQrPath` + `companyDetails?.qrCode`; `pickPaymentQr` / `clearSelectedPaymentQr`
- Produces: UI section under working hours in Store Profile card

- [ ] **Step 1: Create `SettingsPaymentQrSection` (`ConsumerWidget`)**

Layout:
- Title `Strings.paymentQrSectionTitle` + hint `Strings.paymentQrHint`
- Tappable preview (~160.r square): local file / network URL / placeholder with `Strings.paymentQrAdd`
- If `selectedQrPath != null`: text button `Strings.paymentQrClearLocal` → `clearSelectedPaymentQr`
- Use `CommonCachedNetworkImage` for remote URL with explicit width/height and memCache
- `Image.file` for local path
- `onTap` → `notifier.pickPaymentQr()`

Keep file under 150 lines.

- [ ] **Step 2: Embed below `_buildWorkingHourFields` in Store Profile `CommonContainer`**

```dart
16.verticalSpace,
const SettingsPaymentQrSection(),
```

- [ ] **Step 3: Analyze**

```bash
dart analyze lib/src/settings/view
```

- [ ] **Step 4: Commit**

```bash
git add lib/src/settings/view
git commit -m "$(cat <<'EOF'
feat: add UPI QR picker to Settings store profile

EOF
)"
```

---

### Task 4: New Bill loadPaymentQr + Show QR sheet

**Files:**
- Modify: `lib/src/new_bill/state/new_bill_state.dart`
- Modify: `lib/src/new_bill/notifier/new_bill_notifier.dart`
- Create: `lib/src/new_bill/view/widget/payment_qr_sheet.dart`
- Modify: `lib/src/new_bill/view/widget/new_bill_footer.dart`

**Interfaces:**
- Consumes: `settingsRepositoryProvider.getCompanyDetails`, optional `settingsProvider` company QR, `tokenServiceProvider`
- Produces:
  - `NewBillState.paymentQrLoaderState` (`LoaderState`, default `loaded`)
  - `NewBillState.paymentQrUrl` (`String?`)
  - `NewBillNotifier.loadPaymentQr()` / `clearPaymentQr()`
  - Footer Show QR → `CommonBottomSheet` + `PaymentQrSheet`

- [ ] **Step 1: Extend Freezed state + build_runner**

```dart
@Default(LoaderState.loaded) LoaderState paymentQrLoaderState,
String? paymentQrUrl,
```

```bash
dart run build_runner build --delete-conflicting-outputs
```

- [ ] **Step 2: Implement `loadPaymentQr` on `NewBillNotifier`**

```dart
Future<void> loadPaymentQr() async {
  // 1) Prefer in-memory settings if provider has data
  try {
    final cached = ref.read(settingsProvider).companyDetails?.qrCode;
    final normalized = normalizeQrCodeUrl(cached);
    if (normalized != null) {
      state = state.copyWith(
        paymentQrLoaderState: LoaderState.loaded,
        paymentQrUrl: normalized,
      );
      return;
    }
  } catch (_) {
    // settings not ready — fall through to network
  }

  state = state.copyWith(paymentQrLoaderState: LoaderState.loading);

  final userIdStr = await ref.read(tokenServiceProvider).getUserId();
  final userId = int.tryParse(userIdStr ?? '') ?? 1;

  return await ref
      .read(settingsRepositoryProvider)
      .getCompanyDetails(userId)
      .fold(
        (left) {
          debugPrint('🔴 API ERROR payment QR: ${left.message}');
          state = state.copyWith(
            paymentQrLoaderState: handleResponseError(left.key),
            paymentQrUrl: null,
          );
        },
        (company) {
          final url = normalizeQrCodeUrl(company.qrCode);
          state = state.copyWith(
            paymentQrLoaderState:
                url == null ? LoaderState.noData : LoaderState.loaded,
            paymentQrUrl: url,
          );
        },
      )
      .catchError((e) {
        debugPrint('🔴 UNEXPECTED ERROR payment QR: $e');
        state = state.copyWith(paymentQrLoaderState: LoaderState.error);
      });
}
```

Note: Settings repo currently swallows GET errors into mock company — `qrCode` will be null → `noData`. That matches empty state. Do not change mock fallback behavior in this task unless needed for real errors; if live API fails, mock still shows empty QR (existing pattern).

Importing `settingsProvider` from settings into new_bill is a **feature cross-import**. Spec allows reading settings for cache. Prefer reading only via:

```dart
// Avoid hard dependency if analyzer forbids: always network-fetch.
```

**Decision locked for implementers:** Always network-fetch in `loadPaymentQr` (no import of `settingsProvider`). Simpler, always fresh URL, avoids feature-boundary import. Spec’s “if in memory” is an optional optimization — **skip it**; always GET.

```dart
Future<void> loadPaymentQr() async {
  state = state.copyWith(paymentQrLoaderState: LoaderState.loading, paymentQrUrl: null);
  final userIdStr = await ref.read(tokenServiceProvider).getUserId();
  final userId = int.tryParse(userIdStr ?? '') ?? 1;
  return await ref.read(settingsRepositoryProvider).getCompanyDetails(userId).fold(
    (left) { /* handleResponseError */ },
    (company) { /* normalize url → loaded / noData */ },
  ).catchError(...);
}
```

`settingsRepositoryProvider` lives in `services/repo_di.dart` — OK to import from new_bill.

- [ ] **Step 3: Create `PaymentQrSheet` widget**

`ConsumerWidget` that:
- On first build, `WidgetsBinding.instance.addPostFrameCallback` → `loadPaymentQr()` once (or parent calls load before show)
- Prefer: footer calls `loadPaymentQr()` then opens sheet
- Watches `Tuple2(paymentQrLoaderState, paymentQrUrl)` via `.select`
- Switch: loading → `CommonLoader`; error/network/server → retry calling `loadPaymentQr`; noData → empty text `Strings.paymentQrEmpty`; loaded → large `CommonCachedNetworkImage` + `Strings.paymentQrScanHelper`

- [ ] **Step 4: Footer — Show QR when UPI**

When `paymentMethod.toLowerCase() == 'upi'`, show a button/chip `Strings.showPaymentQr` above or beside the method row that:

```dart
onTap: () async {
  await ref.read(newBillNotifierProvider.notifier).loadPaymentQr();
  if (!context.mounted) return;
  CommonBottomSheet.show(
    context: context,
    title: Strings.paymentQrSheetTitle,
    child: const PaymentQrSheet(),
  );
}
```

(Adjust to actual provider name: verify `newBillProvider` vs `newBillNotifierProvider` in codebase — use the existing one.)

Do not block Save/Print.

- [ ] **Step 5: Analyze + manual checklist**

```bash
dart analyze lib/src/new_bill lib/src/settings
flutter test test/utils/helpers/payment_qr_helper_test.dart test/src/settings/model/company_details_model_test.dart
```

Manual:
1. Settings → pick png → Save → QR preview shows network image after refresh
2. New Bill → UPI → Show QR → large image
3. No QR uploaded → empty copy
4. Pick heic/webp if picker returns it → unsupported toast

- [ ] **Step 6: Commit**

```bash
git add lib/src/new_bill
git commit -m "$(cat <<'EOF'
feat: show UPI payment QR sheet on new bill

EOF
)"
```

---

## Self-review (plan vs spec)

| Spec requirement | Task |
|------------------|------|
| GET parse `qr_code` | Task 1 |
| Multipart PUT + optional file | Task 2 |
| Settings preview/pick/clear local | Task 3 |
| Show QR on New Bill when UPI | Task 4 |
| jpg/jpeg/png only | Tasks 1–2 |
| Empty/error states | Task 4 |
| EN+ML strings | Task 2 |
| No delete remote / no preview QR / no prefs cache | Honored |

No TBD placeholders. `loadPaymentQr` always fetches (locked) to avoid cross-feature Settings provider import.
