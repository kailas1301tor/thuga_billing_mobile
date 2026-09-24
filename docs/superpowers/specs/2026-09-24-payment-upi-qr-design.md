# Payment UPI QR — Design Spec

**Date:** 2026-09-24  
**Branch:** `feature/qr-code`  
**Status:** Approved (Approach 1)

## Goal

Let the store owner upload a UPI payment QR image on company profile, and show that QR on New Bill when payment method is UPI so the customer can scan and pay before the bill is saved.

## Context

- “Profile” in Thuka is **Settings → Store Profile**, backed by `GET` / `PUT` `/api/company-details` ([`settings_repository.dart`](../../../lib/src/settings/repo/settings_repository.dart)).
- `AppConstants.getProfileData` (`/api/v1/user/profile`) is unused; this feature does **not** use it.
- Billing records payment method/status only; there is no payment gateway. UPI is already a dropdown method with a QR-scanner **icon** only ([`new_bill_footer.dart`](../../../lib/src/new_bill/view/widget/new_bill_footer.dart)).
- Product image upload already uses `FormData` + `putMultiPartRequest` / `multiPartRequest` and [`FileSelectionService`](../../../lib/utils/helpers/file_picker.dart). Reuse that pattern.

## Approach

**Approach 1 — Extend Settings + Show QR sheet**

1. Parse/upload `qr_code` on company-details.
2. Settings UI to pick/preview/save the QR image.
3. New Bill footer “Show QR” when method is UPI → large sheet with the network image (fetch company details if URL not already in memory).

## API / Data

### GET `/api/company-details?id={companyId}`

- Response `results.data` includes `qr_code`: URL string or null/empty.
- Map to `CompanyDetailsModel.qrCode` (`String?`) via `convertToString`; treat empty as `null`.
- Mock fallback company: `qrCode: null`.

### PUT `/api/company-details` (multipart)

- Change update path from JSON `putRequest` to **`putMultiPartRequest`** with `FormData`.
- Always send text fields as form map keys:
  - `id`, `email`, `company_name`, `address`, `phone_number`, `start_working_hour`, `end_working_hour`
  - optional `password` when non-empty
- Attach `qr_code` as `MultipartFile.fromFile(...)` **only when** the user selected a new local image this save.
- If no new local file: FormData text-only; remote QR unchanged.
- Supported upload types: **jpg, jpeg, png** only (reject others before upload).
- Size limit: `AppConstants.maxImageSizeMb` (existing).

### Repository

- Notifier builds `FormData` (product pattern).
- `SettingsRepo.updateCompanyDetails` accepts `FormData` and calls `putMultiPartRequest`.
- On successful save: re-fetch `getCompanyDetails` so `qrCode` URL replaces any local pick path in state.

## Settings UI

Location: Store Profile card in [`settings_content_widget.dart`](../../../lib/src/settings/view/widget/settings_content_widget.dart), below working hours.

- Label for payment / UPI QR (EN + ML via `assets/l10n` + `Strings.`).
- Preview:
  - Local `selectedQrPath` → `Image.file`
  - Else remote `companyDetails.qrCode` → `CommonCachedNetworkImage` (explicit size + memCache)
  - Else placeholder + add copy
- Tap → `FileSelectionService.instance.pickImage()`, then validate extension is `.jpg` / `.jpeg` / `.png` (HEIC/other → error toast, do not set path).
- Clear control for a newly picked local file only (discard before save). Deleting a remote QR is **out of scope**.
- Existing Save button: validate fields → build FormData → PUT → toast → re-fetch company details → clear `selectedQrPath`.

### State ([`settings_state.dart`](../../../lib/src/settings/state/settings_state.dart))

- `selectedQrPath` (`String?`) for local pick.
- Remote URL lives on `companyDetails.qrCode` (no duplicate field required).
- After successful save + re-fetch: `selectedQrPath: null`, `companyDetails` updated.

## New Bill — Show QR

- Visible only when `paymentMethod` equals UPI (case-insensitive).
- Control: secondary “Show QR” action in the footer near the payment method control (does not replace Save/Print).
- Opens a large `CommonBottomSheet` (near full height):
  1. If `settingsProvider` is available and `companyDetails?.qrCode` is non-empty → show immediately.
  2. Else → `getCompanyDetails` once with sheet-level loader (`LoaderState` on New Bill state or a thin sheet notifier).
  3. Image: `CommonCachedNetworkImage`, large, centered, with memCache caps.
  4. Short helper copy under the image (scan to pay).
  5. Empty (no URL): copy directing owner to Settings → Store Profile.
  6. Fetch error: error UI + retry.
- Does **not** block save/print.

Prefer loading QR via New Bill notifier fields (`paymentQrLoaderState`, `paymentQrUrl`) so the sheet stays a `ConsumerWidget` without ad-hoc `StatefulWidget` business logic.

## Errors & empty states

| Case | Behavior |
|------|----------|
| Wrong file type | Error toast; do not set `selectedQrPath` |
| Over max size | Handled by `FileSelectionService` / toast; do not set path |
| PUT failure | Error toast; keep local pick for retry; map via existing error handling |
| Show QR loading | Sheet loader |
| Show QR network/server error | Error + retry |
| No `qr_code` | Empty state → Settings Store Profile copy |

## Localization

Add keys to **both** `assets/l10n/en.json` and `ml.json`, expose via `Strings.`:

- Payment QR section title / hint / add CTA
- Show QR button label
- Sheet title + scan helper
- Empty QR message
- Unsupported QR type message (jpg/jpeg/png)

## Out of scope

- Delete remote QR via API
- Generate QR from UPI ID string
- QR on bill preview / after save
- SharedPreferences cache of QR URL
- `/api/v1/user/profile` endpoint
- Payment gateway / UPI intent deep links

## Testing

- Unit: `CompanyDetailsModel.fromJson` for `qr_code` null / empty / URL.
- Manual: Settings pick → save → GET shows URL; New Bill UPI → Show QR → large image; no QR uploaded → empty state; non-png/jpg pick rejected.

## Success criteria

1. Owner can upload a jpg/jpeg/png UPI QR from Settings and see it after save.
2. On New Bill with UPI selected, Show QR displays that image large enough for a customer to scan.
3. Missing QR and upload/fetch failures have clear, localized feedback.
