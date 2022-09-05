import ProjectDescription

let project = Project(
  name: "Kineo",
  organizationName: "Cocoatype, LLC",
  targets: [
    Target(
      name: "Kineo",
      platform: .iOS,
      product: .app,
      bundleId: "com.flipbookapp.flickbook",
      infoPlist: "App/Info.plist",
      sources: ["App/Sources/**"],
      resources: ["App/Resources/**"],
      dependencies: [
        .target(name: "Clip"),
        .target(name: "Core"),
        .target(name: "Data"),
        .target(name: "Stickers")
      ]
    ),
    Target(
      name: "Clip",
      platform: .iOS,
      product: .appClip,
      bundleId: "com.flipbookapp.flickbook.Clip",
      infoPlist: "Clip/Info.plist",
      sources: ["Clip/Sources/**"],
      entitlements: "Clip/Clip.entitlements",
      dependencies: [
        .target(name: "Core"),
        .target(name: "Data"),
        .sdk(name: "AppClip", type: .framework, status: .required)
      ]
    ),
    Target(
      name: "Core",
      platform: .iOS,
      product: .framework,
      bundleId: "com.flipbookapp.flickbook.Core",
      sources: ["Core/Sources/**"],
      dependencies: [
        .external(name: "Introspect"),
        .external(name: "Lottie")
      ]
    ),
    Target(
      name: "Data",
      platform: .iOS,
      product: .framework,
      bundleId: "com.flipbookapp.flickbook.Data",
      infoPlist: "Data/Info.plist",
      sources: ["Data/Sources/**"],
      headers: .headers(
        public: ["Sources/Data.h"]
      ),
      dependencies: [
        .target(name: "Shared")
      ]
    ),
    Target(
      name: "Shared",
      platform: .iOS,
      product: .framework,
      bundleId: "com.flipbookapp.flickbook.Shared",
      sources: ["Shared/Sources/**"]
    ),
    Target(
      name: "Stickers",
      platform: .iOS,
      product: .appExtension,
      bundleId: "com.flipbookapp.flickbook.Stickers",
      infoPlist: "Stickers/Info.plist",
      sources: ["Stickers/Sources/**"],
      resources: ["Stickers/Resources/**"],
      entitlements: "Stickers/Stickers.entitlements",
      dependencies: [
        .target(name: "Data")
      ]
    ),
    Target(
      name: "Tests",
      platform: .iOS,
      product: .unitTests,
      bundleId: "com.flipbookapp.flickbook.Tests",
      infoPlist: "Tests/Info.plist",
      sources: ["Tests/Sources/**"],
      resources: ["Tests/Sources/**"]
    )
  ]
)
