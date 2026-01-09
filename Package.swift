// swift-tools-version: 6.2

import PackageDescription
import CompilerPluginSupport

let package = Package(
	name: "swift-associated-objects",
	platforms: [
		.macOS(.v10_15),
		.macCatalyst(.v13),
		.iOS(.v13),
		.tvOS(.v13),
		.watchOS(.v6)
	],
	products: [
		.library(
			name: "AssociatedObjects",
			targets: ["AssociatedObjects"]
		),
		.library(
			name: "AssociatedObjectsMacros",
			targets: ["AssociatedObjectsMacros"]
		)
	],
	dependencies: [
		.package(
			url: "https://github.com/stackotter/swift-macro-toolkit.git",
			.upToNextMinor(from: "0.8.0")
		),
		.package(
			url: "https://github.com/pointfreeco/swift-macro-testing.git",
			.upToNextMinor(from: "0.6.0")
		)
	],
	targets: [
		.target(name: "AssociatedObjects"),
		.target(
			name: "AssociatedObjectsMacros",
			dependencies: [
				.target(name: "AssociatedObjects"),
				.target(name: "AssociatedObjectsMacrosPlugin"),
			]
		),
		.macro(
			name: "AssociatedObjectsMacrosPlugin",
			dependencies: [
				.product(
					name: "MacroToolkit",
					package: "swift-macro-toolkit"
				)
			]
		),
		.testTarget(
			name: "AssociatedObjectsTests",
			dependencies: [
				.target(name: "AssociatedObjects"),
			]
		),
		.testTarget(
			name: "AssociatedObjectsMacrosTests",
			dependencies: [
				.target(name: "AssociatedObjectsMacros"),
			]
		),
		.testTarget(
			name: "AssociatedObjectsMacrosPluginTests",
			dependencies: [
				.target(name: "AssociatedObjectsMacrosPlugin"),
				.product(name: "MacroTesting", package: "swift-macro-testing"),
			]
		),
	],
	swiftLanguageModes: [.v6]
)
