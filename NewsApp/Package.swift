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
      name: "NewsUI",
      targets: ["NewsUI"]
    ),
    .library(
      name: "NewsCore",
      targets: ["NewsCore"]
    ),
    .library(
      name: "LaunchFeature",
      targets: ["LaunchFeature"]
    ),
    .library(
      name: "NewsFeedFeature",
      targets: ["NewsFeedFeature"]
    )
  ],
  dependencies: [
    .package(
      url: "https://github.com/SnapKit/SnapKit.git",
      .upToNextMajor(
        from: "5.0.1"
      )
    )
  ],
  targets: [
    .target(
      name: "NewsApp",
      dependencies: [
        "NewsUI",
        "NewsCore",
        "LaunchFeature",
        "NewsFeedFeature"
      ]
    ),
    .target(name: "NewsUI"),
    .target(name: "NewsCore"),
    .target(
      name: "LaunchFeature",
      dependencies: [
        "NewsUI",
        "NewsCore",
        "SnapKit"
      ]
    ),
    .target(
      name: "NewsFeedFeature",
      dependencies: [
        "NewsUI",
        "NewsCore",
        "SnapKit"
      ]
    )
  ]
)
