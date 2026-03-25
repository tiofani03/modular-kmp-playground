// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

// swift-tools-version:6.1
import PackageDescription

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
            path: "Frameworks/shared.xcframework"
        ),

        .target(
            name: "SharedUIIOS",
            dependencies: ["shared"]
        )
    ]
)
