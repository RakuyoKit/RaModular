// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "RaModular",
  platforms: [.iOS(.v13)],
  products: [
    .library(name: "RaModular", targets: ["RaModular"]),
    .library(name: "RaModularCore", targets: ["RaModularCore"]),
    .library(name: "RaModularRouter", targets: ["RaModularRouter"]),
    .library(name: "RaModularBehavior", targets: ["RaModularBehavior"]),
  ],
  targets: [
    .target(
      name: "RaModular",
      dependencies: [
        "RaModularCore",
        "RaModularRouter",
        "RaModularBehavior",
      ]),
    .target(name: "RaModularCore"),
    .target(name: "RaModularRouter", dependencies: ["RaModularCore"]),
    .target(name: "RaModularBehavior", dependencies: ["RaModularCore"]),
    .testTarget(name: "RaModularTests", dependencies: ["RaModular"]),
  ])
