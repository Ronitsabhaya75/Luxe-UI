// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "LuxeUI",
    platforms: [
        .iOS(.v15),
        .macOS(.v12)
    ],
    products: [
        .library(name: "LuxeUI", targets: ["LuxeUI"]),
        .executable(name: "CoreComponentsDemo", targets: ["CoreComponentsDemo"]),
        .executable(name: "LiquidUIDemo", targets: ["LiquidUIDemo"]),
    ],
    targets: [
        .target(
            name: "LuxeUI",
            dependencies: []
        ),
        .executableTarget(
            name: "CoreComponentsDemo",
            dependencies: ["LuxeUI"],
            path: "Examples/CoreComponentsDemo"
        ),
        .executableTarget(
            name: "LiquidUIDemo",
            dependencies: ["LuxeUI"],
            path: "Examples/LiquidUIDemo"
        ),
        .testTarget(
            name: "LuxeUITests",
            dependencies: ["LuxeUI"]
        ),
    ]
)