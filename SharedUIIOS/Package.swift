// swift-tools-version: 5.9
import PackageDescription

// These values are automatically updated by the CI/CD release workflow.
// Do not edit XCFRAMEWORK_URL or XCFRAMEWORK_CHECKSUM manually.
let xcframeworkURL = "https://github.com/tiofani03/modular-kmp-playground/releases/download/v0.0.1-test/shared.xcframework.zip"
let xcframeworkChecksum = "88e86abc9e7528114cd98393ab7d70cb337cd07deaedad13d683e94d95d8fa10"

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
