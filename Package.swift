// swift-tools-version: 6.4
import PackageDescription
let package = Package(
    name: "swift-vector",
    platforms: [.macOS(.v27), .iOS(.v27), .tvOS(.v27), .watchOS(.v27), .visionOS(.v27)],
    products: [
        .library(name: "Vector", targets: ["Vector"]),
        .library(name: "Vector Standard Library Integration", targets: ["Vector Standard Library Integration"]),
        .library(name: "Vector Foundation Library Integration", targets: ["Vector Foundation Library Integration"]),
        .library(name: "Vector Test Support", targets: ["Vector Test Support"]),
    ],
    dependencies: [

    ],
    targets: [
        .target(name: "Vector", dependencies: [], path: "Sources/Vector"),
        .target(name: "Vector Standard Library Integration", dependencies: ["Vector"], path: "Sources/Vector Standard Library Integration"),
        .target(name: "Vector Foundation Library Integration", dependencies: ["Vector", "Vector Standard Library Integration"], path: "Sources/Vector Foundation Library Integration"),
        .target(name: "Vector Test Support", dependencies: ["Vector"], path: "Tests/Support"),
        .testTarget(name: "Vector Tests", dependencies: ["Vector", "Vector Test Support", "Vector Standard Library Integration", "Vector Foundation Library Integration"], path: "Tests/Vector Tests"),
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
