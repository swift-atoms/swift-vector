// swift-tools-version: 6.4
import PackageDescription
let package = Package(
    name: "swift-vector",
    platforms: [.macOS(.v27), .iOS(.v27), .tvOS(.v27), .watchOS(.v27), .visionOS(.v27)],
    products: [
        .library(name: "Vector", targets: ["Vector"]),

        .library(name: "Vector Foundation Integration", targets: ["Vector Foundation Integration"]),
        .library(name: "Vector Test Support", targets: ["Vector Test Support"]),
    ],
    traits: [
        .trait(name: "Shear", description: "Shear integration"),
        .trait(name: "Iterator", description: "Iterator integration"),
        .trait(name: "Sequence", description: "Sequence integration", enabledTraits: ["Iterator"]),
    ],
    dependencies: [
        .package(url: "https://github.com/swift-atoms/swift-shear.git", branch: "main"),
        .package(url: "https://github.com/swift-atoms/swift-iterator.git", branch: "main"),
        .package(url: "https://github.com/swift-atoms/swift-sequence.git", branch: "main"),
        .package(url: "https://github.com/swift-atoms/swift-cardinal.git", branch: "main"),
    ],
    targets: [
        .target(name: "Vector", dependencies: [
                .product(name: "Shear", package: "swift-shear", condition: .when(traits: ["Shear"])),
                .product(name: "Iterator", package: "swift-iterator", condition: .when(traits: ["Iterator", "Sequence"])),
                .product(name: "Sequence", package: "swift-sequence", condition: .when(traits: ["Sequence"])),
                .product(name: "Cardinal", package: "swift-cardinal", condition: .when(traits: ["Sequence"])),
            ], path: "Sources/Vector"),

        .target(name: "Vector Foundation Integration", dependencies: [
                .target(name: "Vector"),
            ], path: "Sources/Vector Foundation Integration"),
        .target(name: "Vector Test Support", dependencies: [
                .target(name: "Vector"),
            ], path: "Tests/Support"),
        .testTarget(name: "Vector Tests", dependencies: [
                .target(name: "Vector"),
                .target(name: "Vector Test Support"),
                .target(name: "Vector Foundation Integration"),
            ], path: "Tests/Vector Tests"),
        .testTarget(
            name: "Vector Shear Tests",
            dependencies: [
                .target(name: "Vector"),
                .product(name: "Shear", package: "swift-shear", condition: .when(traits: ["Shear"])),
            ],
            path: "Tests/Vector Shear Tests"
        ),
        .testTarget(name: "Vector Iterator Integration Tests", dependencies: [.target(name: "Vector"), .target(name: "Vector Test Support"), .product(name: "Iterator", package: "swift-iterator", condition: .when(traits: ["Iterator", "Sequence"]))], path: "Tests/Vector Iterator Integration Tests"),
        .testTarget(name: "Vector Sequence Integration Tests", dependencies: [.target(name: "Vector"), .target(name: "Vector Test Support"), .product(name: "Sequence", package: "swift-sequence", condition: .when(traits: ["Sequence"])), .product(name: "Cardinal", package: "swift-cardinal", condition: .when(traits: ["Sequence"]))], path: "Tests/Vector Sequence Integration Tests"),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets where ![.system, .binary, .plugin].contains(target.type) {
    target.swiftSettings = (target.swiftSettings ?? []) + [
        .strictMemorySafety(),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableUpcomingFeature("InferIsolatedConformances"),
        .enableExperimentalFeature("Lifetimes"),
        .treatAllWarnings(as: .error),
    ]
}
