// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "TibetanCalendarData",
    platforms: [
        .iOS(.v13),
        .macOS(.v11)
    ],
    products: [
        .library(
            name: "TibetanCalendarData",
            targets: ["TibetanCalendarData"]),
    ],
    targets: [
        .target(
            name: "TibetanCalendarData",
            resources: [.process("Resources")]),
        .testTarget(
            name: "TibetanCalendarDataTests",
            dependencies: ["TibetanCalendarData"]),
    ]
)
