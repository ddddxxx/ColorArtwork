// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ColorArtwork",
    products: [
        .library(
            name: "ColorArtwork",
            targets: ["ColorArtwork"]),
        ],
    targets: [
        .target(
            name: "ColorArtwork"),
        .testTarget(
            name: "ColorArtworkTests",
            dependencies: ["ColorArtwork"])
    ]
)
