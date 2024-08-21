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
      name: "NetworkingService",
      targets: ["NetworkingService"]
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
    ),
    .package(
      url: "https://github.com/SDWebImage/SDWebImage.git",
      from: "5.1.0"
    )
  ],
  targets: [
    .target(
      name: "NewsApp",
      dependencies: [
        "NewsUI",
        "NewsCore",
        "NetworkingService",
        "LaunchFeature",
        "NewsFeedFeature"
      ]
    ),
    .target(name: "NewsUI", dependencies: ["SnapKit"]),
    .target(name: "NewsCore"),
    .target(name: "NetworkingService"),
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
        "SnapKit",
        "SDWebImage"
      ]
    ),
    .testTarget(
      name: "MainPageTests",
      dependencies: [
        "NewsFeedFeature",
        "NetworkingService"
      ]
    ),
    .testTarget(
      name: "NetworkingServiceTests",
      dependencies: [
        "NetworkingService"
      ]
    ),
    .testTarget(
      name: "NewsAppTests",
      dependencies: [
        "NewsApp"
      ]
    )
  ]
)
