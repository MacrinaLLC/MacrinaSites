// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MacrinaSites",
    products: [
        .library(
            name: "MacrinaSites",
            targets: ["MacrinaSites"]),
    ],
    dependencies: [
        .package(name: "Publish", url: "https://github.com/johnsundell/publish.git", from: "0.7.0")
    ],
    targets: [
        .target(
            name: "MacrinaSites",
            dependencies: ["Publish"]),
        .testTarget(
            name: "MacrinaSitesTests",
            dependencies: ["MacrinaSites"]),
    ]
)
