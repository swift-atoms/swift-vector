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
            name: "Vector Primitive",
            targets: ["Vector Primitive"]
        ),

        .library(
            name: "Vector",
            targets: ["Vector"]
        ),
        .library(
            name: "Vector Standard Library Integration",
            targets: ["Vector Standard Library Integration"]
        ),
        .library(
            name: "Vector Test Support",
            targets: ["Vector Test Support"]
        ),
    ],
    dependencies: [
        .package(
            url: "https://github.com/swift-molecules/swift-index.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-molecules/swift-property.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-molecules/swift-sequence.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-molecules/swift-iterator.git",
            branch: "main"
        ),
    ],
    targets: [

        .target(
            name: "Vector Primitive",
            dependencies: [
                .product(name: "Index", package: "swift-index"),
                .product(name: "Property", package: "swift-property"),
            ]
        ),

        .target(
            name: "Vector Standard Library Integration",
            dependencies: [
                "Vector Primitive"
            ]
        ),

        .target(
            name: "Vector",
            dependencies: [
                "Vector Primitive",
                "Vector Standard Library Integration",
                .product(name: "Sequence", package: "swift-sequence"),
                .product(name: "Iterable", package: "swift-iterator"),
                .product(name: "Iterator Chunk", package: "swift-iterator"),
                .product(name: "Iterator Witness", package: "swift-iterator"),
            ]
        ),
        .target(
            name: "Vector Test Support",
            dependencies: [
                "Vector",
                .product(name: "Index Test Support", package: "swift-index"),
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
