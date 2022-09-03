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
        .external(name: "Introspect"),
        .external(name: "Lottie"),
        .target(name: "Clip"),
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
      resources: ["Clip/Resources/**"],
      entitlements: "Clip/Clip.entitlements",
      dependencies: [
        .target(name: "Data"),
        .sdk(name: "AppClip", type: .framework, status: .required)
      ]
    ),
    Target(
      name: "Data",
      platform: .iOS,
      product: .framework,
      bundleId: "com.flipbookapp.flickbook.Data",
      infoPlist: "Data/Info.plist",
      sources: ["Data/Sources/**"],
      resources: ["Data/Resources/**"],
      headers: .headers(
        public: ["Sources/Data.h"]
      )
    ),
    Target(
      name: "Stickers",
      platform: .iOS,
      product: .appExtension,
      bundleId: "com.flipbookapp.flickbook.Stickers",
      infoPlist: "Stickers/Info.plist",
      sources: ["Stickers/Sources/**"],
      resources: ["Stickers/Resources/**"],
      entitlements: "Stickers/Stickers.entitlements"
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
