// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CoreSwift",
    platforms: [ .iOS(.v11)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "CoreSwift",
            targets: ["CoreSwift"]),
    ],
    dependencies: [
        .package(url: "https://github.com/ashleymills/Reachability.swift", .exact("5.0.0")),
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        .binaryTarget(name: "CoreSwift", path: "./Sources/CoreSwift.xcframework")
    ]
)
