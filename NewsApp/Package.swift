// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "NewsApp",
  defaultLocalization: "en",
  platforms: [.iOS(.v15)],
  products: [
    .library(
      name: "NewsApp",
      targets: ["NewsApp"]
    )
  ],
  targets: [
    .target(
      name: "NewsApp"),
    .testTarget(
      name: "NewsAppTests",
      dependencies: ["NewsApp"]
    )
  ]
)
