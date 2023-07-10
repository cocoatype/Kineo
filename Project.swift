import ProjectDescription

let project = Project(
  name: "Kineo",
  organizationName: "Cocoatype, LLC",
  settings: .settings(
    base: [
      "CURRENT_PROJECT_VERSION": "0",
      "DEVELOPMENT_TEAM": "287EDDET2B",
      "IPHONEOS_DEPLOYMENT_TARGET": "14.0"
    ],
    debug: [
      "CODE_SIGN_IDENTITY": "Apple Development: Buddy Build (D47V8Y25W5)"
    ]
  ),
  targets: [
    Target(
      name: "Kineo",
      platform: .iOS,
      product: .app,
      bundleId: "com.flipbookapp.flickbook",
      infoPlist: "App/Info.plist",
      sources: ["App/Sources/**"],
      resources: ["App/Resources/**"],
      entitlements: "App/Kineo.entitlements",
      dependencies: [
        .target(name: "Clip"),
        .target(name: "Core"),
        .target(name: "Data"),
        .target(name: "Stickers")
      ],
      settings: .settings(
        debug: [
          "PROVISIONING_PROFILE_SPECIFIER": "match Development com.flipbookapp.flickbook"
        ],
        release: [
          "CODE_SIGN_IDENTITY": "iPhone Distribution",
          "PROVISIONING_PROFILE_SPECIFIER": "match AppStore com.flipbookapp.flickbook"
        ]
      )
    ),
    Target(
      name: "Canvas",
      platform: .iOS,
      product: .framework,
      bundleId: "com.flipbookapp.flickbook.Canvas",
      sources: ["Canvas/Sources/**"],
      dependencies: [
        .target(name: "Data"),
        .target(name: "DocumentNavigation"),
        .target(name: "EditingState")
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
      ],
      settings: .settings(
        debug: [
          "CODE_SIGN_IDENTITY": "Apple Development: Buddy Build (D47V8Y25W5)",
          "PROVISIONING_PROFILE_SPECIFIER": "match Development com.flipbookapp.flickbook.Clip"
        ],
        release: [
          "CODE_SIGN_IDENTITY": "Apple Distribution",
          "PROVISIONING_PROFILE_SPECIFIER": "match AppStore com.flipbookapp.flickbook.Clip"
        ]        
      )
    ),
    Target(
      name: "Core",
      platform: .iOS,
      product: .framework,
      bundleId: "com.flipbookapp.flickbook.Core",
      sources: ["Core/Sources/**"],
      dependencies: [
        .external(name: "Introspect"),
        .external(name: "Lottie"),
        .target(name: "Canvas"),
        .target(name: "Data"),
        .target(name: "DocumentNavigation"),
        .target(name: "EditingState")
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
      ],
      settings: .settings(
        base: [
          "APPLICATION_EXTENSION_API_ONLY": "YES"
        ]
      )
    ),
    Target(
      name: "DocumentNavigation",
      platform: .iOS,
      product: .framework,
      bundleId: "com.flipbookapp.flickbook.DocumentNavigation",
      sources: ["DocumentNavigation/Sources/**"],
      dependencies: []
    ),
    Target(
      name: "EditingState",
      platform: .iOS,
      product: .framework,
      bundleId: "com.flipbookapp.flickbook.EditingState",
      sources: ["EditingState/Sources/**"],
      dependencies: [
        .target(name: "Data"),
        .target(name: "DocumentNavigation")
      ]
    ),
    Target(
      name: "Shared",
      platform: .iOS,
      product: .framework,
      bundleId: "com.flipbookapp.flickbook.Shared",
      sources: ["Shared/Sources/**"],
      settings: .settings(
        base: [
          "APPLICATION_EXTENSION_API_ONLY": "YES"
        ]
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
      entitlements: "Stickers/Stickers.entitlements",
      dependencies: [
        .target(name: "Data")
      ],
      settings: .settings(
        debug: [
          "CODE_SIGN_IDENTITY": "Apple Development: Buddy Build (D47V8Y25W5)",
          "PROVISIONING_PROFILE_SPECIFIER": "match Development com.flipbookapp.flickbook.Stickers"
        ],
        release: [
          "CODE_SIGN_IDENTITY": "Apple Distribution",
          "PROVISIONING_PROFILE_SPECIFIER": "match AppStore com.flipbookapp.flickbook.Stickers"
        ]        
      )
    ),
    Target(
      name: "Tests",
      platform: .iOS,
      product: .unitTests,
      bundleId: "com.flipbookapp.flickbook.Tests",
      infoPlist: "Tests/Info.plist",
      sources: ["Tests/Sources/**"]
    )
  ],
  schemes: [
    Scheme(
      name: "Kineo",
      shared: true,
      buildAction: .buildAction(targets: ["Kineo"]),
      testAction: .targets(["Tests"]),
      runAction: .runAction(executable: "Kineo")
    )
  ]
)
