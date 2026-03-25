// swift-tools-version: 5.9
import PackageDescription

// These values are automatically updated by the CI/CD release workflow.
// Do not edit XCFRAMEWORK_URL or XCFRAMEWORK_CHECKSUM manually.
let xcframeworkURL = "https://github.com/tiofani03/modular-kmp-playground/releases/download/PLACEHOLDER_VERSION/shared.xcframework.zip"
let xcframeworkChecksum = "PLACEHOLDER_CHECKSUM"

let package = Package(
    name: "SharedUIIOS",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "SharedUIIOS",
            targets: ["SharedUIIOS"]
        )
    ],
    targets: [

        .binaryTarget(
            name: "shared",
            url: xcframeworkURL,
            checksum: xcframeworkChecksum
        ),

        .target(
            name: "SharedUIIOS",
            dependencies: ["shared"]
        )
    ]
)
