#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PROJECT="$ROOT_DIR/mypixelpet.xcodeproj"
SCHEME="mypixelpet"
DERIVED_DATA="$ROOT_DIR/.build/ReleaseDerivedData"
BUILD_APP="$DERIVED_DATA/Build/Products/Release/mypixelpet.app"
DIST_DIR="$ROOT_DIR/dist"
STAGING_DIR="$ROOT_DIR/.build/dmg-root"
INSTALL_APP="$STAGING_DIR/MyPixelPet.app"
DMG_PATH="$DIST_DIR/MyPixelPet.dmg"

rm -rf "$DERIVED_DATA" "$STAGING_DIR"
mkdir -p "$DIST_DIR" "$STAGING_DIR"

xcodebuild \
  -project "$PROJECT" \
  -scheme "$SCHEME" \
  -configuration Release \
  -destination "platform=macOS" \
  -derivedDataPath "$DERIVED_DATA" \
  CODE_SIGNING_ALLOWED=NO \
  build

ditto "$BUILD_APP" "$INSTALL_APP"
codesign --force --deep --sign - "$INSTALL_APP"
ln -s /Applications "$STAGING_DIR/Applications"

rm -f "$DMG_PATH"
hdiutil create \
  -volname "MyPixelPet" \
  -srcfolder "$STAGING_DIR" \
  -ov \
  -format UDZO \
  "$DMG_PATH"

codesign --verify --deep --strict --verbose=2 "$INSTALL_APP"
spctl --assess --type execute --verbose=2 "$INSTALL_APP" || true

echo "$DMG_PATH"
