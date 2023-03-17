// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "RaServices",
  platforms: [.iOS(.v13)],
  products: [
    .library(name: "RaServices", targets: ["RaServices"]),
    .library(name: "RaServicesCore", targets: ["RaServicesCore"]),
    .library(name: "RaServicesBehavior", targets: ["RaServicesBehavior"]),
    .library(name: "RaServicesURLNavigate", targets: ["RaServicesURLNavigate"]),
  ],
  targets: [
    .target(
      name: "RaServices",
      dependencies: [
        "RaServicesCore",
        "RaServicesBehavior",
        "RaServicesURLNavigate",
      ]),
    .target(name: "RaServicesCore"),
    .target(name: "RaServicesBehavior", dependencies: ["RaServicesCore"]),
    .target(name: "RaServicesURLNavigate", dependencies: ["RaServicesCore"]),
    .testTarget(name: "RaServicesTests", dependencies: ["RaServices"]),
  ])
