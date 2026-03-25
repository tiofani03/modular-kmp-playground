#!/bin/bash
# kmp_ios_builder.sh
#
# Builds the Shared KMP XCFramework, copies it into the SharedUIIOS Swift
# Package, and (optionally) zips the framework and prints the SPM checksum
# so it can be referenced as a remote binary target.
#
# Usage:
#   ./scripts/kmp_ios_builder.sh            # build + copy (local dev)
#   ./scripts/kmp_ios_builder.sh --release  # build + copy + zip + checksum
set -e

RELEASE_MODE=false
for arg in "$@"; do
    [[ "$arg" == "--release" ]] && RELEASE_MODE=true
done

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
XCFRAMEWORK_NAME="shared"
XCFRAMEWORK_SRC="$ROOT_DIR/shared/build/XCFrameworks/release/$XCFRAMEWORK_NAME.xcframework"
XCFRAMEWORK_DST="$ROOT_DIR/SharedUIIOS/Frameworks/$XCFRAMEWORK_NAME.xcframework"
ZIP_DIR="$ROOT_DIR/shared/build/distributions"
ZIP_FILE="$ZIP_DIR/$XCFRAMEWORK_NAME.xcframework.zip"

echo "==> Building KMP XCFramework..."
cd "$ROOT_DIR"
./gradlew :shared:assembleSharedReleaseXCFramework

echo "==> Copying XCFramework to Swift Package..."
rm -rf "$XCFRAMEWORK_DST"
mkdir -p "$(dirname "$XCFRAMEWORK_DST")"
cp -R "$XCFRAMEWORK_SRC" "$XCFRAMEWORK_DST"
echo "    Copied to: $XCFRAMEWORK_DST"

if [ "$RELEASE_MODE" = true ]; then
    echo "==> Zipping XCFramework..."
    mkdir -p "$ZIP_DIR"
    # Zip from the parent directory so the archive root is <name>.xcframework
    (cd "$(dirname "$XCFRAMEWORK_SRC")" && zip -r "$ZIP_FILE" "$XCFRAMEWORK_NAME.xcframework")
    echo "    Archive: $ZIP_FILE"

    echo "==> Computing SPM checksum..."
    CHECKSUM=$(swift package compute-checksum "$ZIP_FILE")
    echo "    Checksum: $CHECKSUM"
    echo ""
    echo "Add the following to Package.swift:"
    echo "  url:      https://github.com/tiofani03/modular-kmp-playground/releases/download/<TAG>/$XCFRAMEWORK_NAME.xcframework.zip"
    echo "  checksum: $CHECKSUM"
fi

echo "==> Done."
