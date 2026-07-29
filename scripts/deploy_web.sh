#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.."

cleanup_overrides() {
  if [[ -f pubspec_overrides.yaml ]]; then
    rm -f pubspec_overrides.yaml
    flutter pub get
  fi
}

trap cleanup_overrides EXIT

echo "Building Flutter web (release)..."
echo "Applying web-only dependency overrides (excludes win_ble / BLEServer.exe)..."
cp tool/pubspec_overrides.web.yaml pubspec_overrides.yaml
flutter pub get
flutter build web --release

echo "Stripping native-only artifacts from web build..."
find build/web -name '*.exe' -delete
find build/web -name '*.dll' -delete
find build/web -name '*.so' -delete
find build/web -name '*.dylib' -delete
rm -rf build/web/assets/packages/win_ble
# CanvasKit wasm files may carry the executable bit from the Flutter SDK cache.
find build/web -type f -perm +111 -exec chmod a-x {} \;

echo "Deploying to Firebase Hosting (thuga-billing)..."
firebase deploy --only hosting

echo "Done."
