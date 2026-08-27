// swift-tools-version: 6.4

import PackageDescription

let package = Package(
    name: "swift-vector",
    platforms: [
        .macOS(.v27),
        .iOS(.v27),
        .tvOS(.v27),
        .watchOS(.v27),
        .visionOS(.v27),
    ],
    products: [
        .library(
            name: "Vector",
            targets: ["Vector"]
        ),
        .library(
            name: "Vector Apple Foundation Integration",
            targets: ["Vector Apple Foundation Integration"]
        ),
        .library(
            name: "Vector Test Support",
            targets: ["Vector Test Support"]
        ),
    ],
    dependencies: [
        .package(
            url: "https://github.com/swift-atoms/swift-index.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-property.git",
            branch: "main"
        ),
    ],
    targets: [
        .target(
            name: "Vector",
            dependencies: [
                .product(name: "Index", package: "swift-index"),
                .product(name: "Property", package: "swift-property"),
            ]
        ),
        .target(
            name: "Vector Apple Foundation Integration",
            dependencies: ["Vector"]
        ),
        .target(
            name: "Vector Test Support",
            dependencies: [
                "Vector",
                .product(name: "Index", package: "swift-index"),
            ],
            path: "Tests/Support"
        ),
        .testTarget(
            name: "Vector Tests",
            dependencies: [
                "Vector",
                "Vector Test Support",
            ]
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets where ![.system, .binary, .plugin, .macro].contains(target.type) {
    let ecosystem: [SwiftSetting] = [
        .strictMemorySafety(),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableExperimentalFeature("Lifetimes"),
        .enableUpcomingFeature("InferIsolatedConformances"),
    ]

    let package: [SwiftSetting] = []

    target.swiftSettings = (target.swiftSettings ?? []) + ecosystem + package
}
