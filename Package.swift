// swift-tools-version: 6.4

import PackageDescription

let package = Package(
    name: "swift-vector-primitives",
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
            name: "Vector Primitives",
            targets: ["Vector Primitives"]
        ),
        .library(
            name: "Vector Primitives Standard Library Integration",
            targets: ["Vector Primitives Standard Library Integration"]
        ),
        .library(
            name: "Vector Primitives Test Support",
            targets: ["Vector Primitives Test Support"]
        ),
    ],
    dependencies: [
        .package(
            url: "https://github.com/swift-primitives/swift-index-primitives.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-primitives/swift-property-primitives.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-primitives/swift-sequence-primitives.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-primitives/swift-iterator-primitives.git",
            branch: "main"
        ),
    ],
    targets: [

        .target(
            name: "Vector Primitive",
            dependencies: [
                .product(name: "Index Primitives", package: "swift-index-primitives"),
                .product(name: "Property Primitives", package: "swift-property-primitives"),
            ]
        ),

        .target(
            name: "Vector Primitives Standard Library Integration",
            dependencies: [
                "Vector Primitive"
            ]
        ),

        .target(
            name: "Vector Primitives",
            dependencies: [
                "Vector Primitive",
                "Vector Primitives Standard Library Integration",
                .product(name: "Sequence Primitives", package: "swift-sequence-primitives"),
                .product(name: "Iterable", package: "swift-iterator-primitives"),
                .product(name: "Iterator Chunk Primitives", package: "swift-iterator-primitives"),
                .product(name: "Iterator Witness Primitives", package: "swift-iterator-primitives"),
            ]
        ),
        .target(
            name: "Vector Primitives Test Support",
            dependencies: [
                "Vector Primitives",
                .product(name: "Index Primitives Test Support", package: "swift-index-primitives"),
            ],
            path: "Tests/Support"
        ),
        .testTarget(
            name: "Vector Primitives Tests",
            dependencies: [
                "Vector Primitives",
                "Vector Primitives Test Support",
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
