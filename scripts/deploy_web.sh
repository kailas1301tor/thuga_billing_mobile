#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.."

echo "Building Flutter web (release)..."
flutter pub get
flutter build web --release

echo "Stripping native-only artifacts from web build..."
# print_bluetooth_thermal → win_ble ships BLEServer.exe; Spark plan rejects executables.
find build/web -name '*.exe' -delete
find build/web -name '*.dll' -delete
find build/web -name '*.so' -delete
find build/web -name '*.dylib' -delete
# CanvasKit wasm files may carry the executable bit from the Flutter SDK cache.
find build/web -type f -perm +111 -exec chmod a-x {} \;

echo "Deploying to Firebase Hosting (thuga-billing)..."
firebase deploy --only hosting

echo "Done."
