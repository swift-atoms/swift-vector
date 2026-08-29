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
            url: "https://github.com/swift-atoms/swift-index.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-property.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-cardinal.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-tagged.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-ordinal.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-affine.git",
            branch: "main"
        ),
    ],
    targets: [

        .target(
            name: "Vector",
            dependencies: [
                .product(name: "Index", package: "swift-index"),
                .product(name: "Property", package: "swift-property"),
                .product(name: "Property Inout", package: "swift-property"),
                .product(name: "Cardinal", package: "swift-cardinal"),
                .product(name: "Cardinal Carrier", package: "swift-cardinal"),
                .product(name: "Tagged", package: "swift-tagged"),
                .product(name: "Ordinal", package: "swift-ordinal"),
                .product(name: "Ordinal Error", package: "swift-ordinal"),
                .product(name: "Ordinal Protocol", package: "swift-ordinal"),
                .product(name: "Ordinal Cardinal", package: "swift-ordinal"),
                .product(name: "Ordinal Advance", package: "swift-ordinal"),
                .product(name: "Ordinal Retreat", package: "swift-ordinal"),
                .product(name: "Ordinal Predecessor", package: "swift-ordinal"),
                .product(name: "Ordinal Distance", package: "swift-ordinal"),
                .product(name: "Ordinal Tagged", package: "swift-ordinal"),
                .product(name: "Affine Arithmetic", package: "swift-affine"),
                .product(name: "Affine Tagged", package: "swift-affine"),
            ]
        ),

        .target(
            name: "Vector Standard Library Integration",
            dependencies: [
                .product(name: "Index", package: "swift-index"),
                .product(
                    name: "Cardinal Standard Library Integration",
                    package: "swift-cardinal"
                ),
                .product(name: "Ordinal Protocol", package: "swift-ordinal"),
                .product(
                    name: "Ordinal Standard Library Integration",
                    package: "swift-ordinal"
                ),
            ]
        ),

        .target(
            name: "Vector Test Support",
            dependencies: [
                .target(name: "Vector"),
                .product(name: "Index Test Support", package: "swift-index"),
                .product(name: "Ordinal", package: "swift-ordinal"),
                .product(name: "Ordinal Protocol", package: "swift-ordinal"),
                .product(name: "Ordinal Tagged", package: "swift-ordinal"),
                .product(name: "Tagged", package: "swift-tagged"),
            ],
            path: "Tests/Support"
        ),
        .testTarget(
            name: "Vector Tests",
            dependencies: [
                .target(name: "Vector"),
                .target(name: "Vector Test Support"),
                .product(name: "Cardinal", package: "swift-cardinal"),
                .product(name: "Cardinal Carrier", package: "swift-cardinal"),
                .product(name: "Cardinal Tagged", package: "swift-cardinal"),
                .product(name: "Tagged", package: "swift-tagged"),
                .product(
                    name: "Tagged Standard Library Integration",
                    package: "swift-tagged"
                ),
                .product(name: "Ordinal Protocol", package: "swift-ordinal"),
                .product(name: "Ordinal Distance", package: "swift-ordinal"),
                .product(name: "Ordinal Tagged", package: "swift-ordinal"),
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
