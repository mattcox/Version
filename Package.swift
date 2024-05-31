// swift-tools-version: 5.10

import PackageDescription

let package = Package(
	name: "Version",
	platforms: [
		.macOS(.v11),
		.iOS(.v14),
		.tvOS(.v14),
		.watchOS(.v7),
		.macCatalyst(.v14),
		.visionOS(.v1)
	],
	products: [
		.library(
			name: "Version",
			targets: [
				"Version"
			]
		),
	],
	targets: [
		.target(
			name: "Version"
		),
		.testTarget(
			name: "VersionTests",
			dependencies: [
				"Version"
			]
		),
	]
)
