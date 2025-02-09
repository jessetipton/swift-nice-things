// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "swift-nice-things",
    products: [
        .library(
            name: "NiceThings",
            targets: ["NiceThings"]
        ),
    ],
    targets: [
        .target(name: "NiceThings"),
        .testTarget(
            name: "NiceThingsTests",
            dependencies: ["NiceThings"]
        ),
    ],
    swiftLanguageModes: [.v6]
)
