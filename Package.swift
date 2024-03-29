// swift-tools-version: 5.9

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
    ]
)
