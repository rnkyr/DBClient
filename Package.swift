// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "DBClient",
    products: [
        .library(name: "DBClient", targets: ["DBClient"]),
        .library(name: "DBClientCoreData", targets: ["DBClientCoreData"])
    ],
    targets: [
        .target(name: "DBClient"),
        .target(name: "DBClientCoreData", dependencies: ["DBClient"]),
    ]
)
