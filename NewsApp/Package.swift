// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "NewsApp",
  defaultLocalization: "en",
  platforms: [.iOS(.v15)],
  products: [
    .library(name: "NewsApp", targets: ["NewsApp"]),
    .library(
      name: "LaunchFeature",
      targets: ["LaunchFeature"]
    ),
    .library(
      name: "NewsUI",
      targets: ["NewsUI"]
    )
  ],
  targets: [
    .target(name: "NewsApp"),
    .target(
      name: "LaunchFeature",
      dependencies: ["NewsUI"]
    ),
    .target(
      name: "NewsUI"
    )
  ]
)
