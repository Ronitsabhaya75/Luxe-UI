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
        .executable(name: "iOSGPUDemo", targets: ["iOSGPUDemo"]),
    ],
    targets: [
        .target(
            name: "LuxeUI",
            dependencies: [],
            resources: [
                .process("GPU/LuxeShaders.metal")
            ]
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
        .executableTarget(
            name: "iOSGPUDemo",
            dependencies: ["LuxeUI"],
            path: "Examples/iOSGPUDemo"
        ),
        .testTarget(
            name: "LuxeUITests",
            dependencies: ["LuxeUI"]
        ),
    ]
)