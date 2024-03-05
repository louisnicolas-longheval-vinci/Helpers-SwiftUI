// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Helpers",
    products: [
        .library(
            name: "Helpers",
            targets: ["ExpandingGradient", "PressAndHoldButton", "PrivacyLabels"]),
    ],
    targets: [
        .target(
            name: "ExpandingGradient",
            dependencies: []),
        .target(
            name: "PressAndHoldButton",
            dependencies: []),
		.target(
			name: "PrivacyLabels",
			dependencies: []),
    ]
)

