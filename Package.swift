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
    dependencies: [

    ],
    targets: [
        .target(name: "Vector", dependencies: [
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
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets {
    target.swiftSettings = [
        .strictMemorySafety(),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableExperimentalFeature("Lifetimes"),
        .enableUpcomingFeature("InferIsolatedConformances"),
    ]
}
