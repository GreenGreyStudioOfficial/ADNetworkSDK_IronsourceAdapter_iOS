// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ADNetworkSDK_IronsourceAdapter",
    products: [
        .library(
            name: "ADNetworkSDK_IronsourceAdapter",
            targets: ["ADNetworkSDK_IronsourceAdapter"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "ADNetworkSDK_IronsourceAdapter",
            dependencies: []),
        .testTarget(
            name: "ADNetworkSDK_IronsourceAdapterTests",
            dependencies: ["ADNetworkSDK_IronsourceAdapter"]),
    ]
)
