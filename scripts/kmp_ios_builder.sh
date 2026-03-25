#!/bin/bash
set -e

echo "Building KMP XCFramework..."

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"

cd "$ROOT_DIR"

./gradlew :shared:assembleXCFramework

echo "Copy XCFramework to Swift Package..."

rm -rf SharedUIIOS/Frameworks/shared.xcframework

cp -R shared/build/XCFrameworks/release/shared.xcframework \
      SharedUIIOS/Frameworks/

echo "Done building KMP"