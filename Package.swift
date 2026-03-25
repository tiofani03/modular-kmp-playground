// swift-tools-version: 5.9
import PackageDescription

// These values are automatically updated by the CI/CD release workflow.
// Do not edit XCFRAMEWORK_URL or XCFRAMEWORK_CHECKSUM manually.
let xcframeworkURL = "https://github.com/tiofani03/modular-kmp-playground/releases/download/v0.0.2-test/shared.xcframework.zip"
let xcframeworkChecksum = "ce9a9a4b196cd7c8bf4c594cb1fe819556997ce5ea85e63b51408adfe006721d"

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
            name: "Shared",
            url: xcframeworkURL,
            checksum: xcframeworkChecksum
        ),

        .target(
            name: "SharedUIIOS",
            dependencies: ["Shared"],
            path: "SharedUIIOS/Sources/SharedUIIOS"
        )
    ]
)
