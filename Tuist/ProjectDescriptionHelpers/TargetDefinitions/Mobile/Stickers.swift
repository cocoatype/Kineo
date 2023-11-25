import ProjectDescription

public extension Mobile {
    enum Stickers {
        public static let target = Target(
            name: "Stickers",
            platform: .iOS,
            product: .appExtension,
            bundleId: "com.flipbookapp.flickbook.Stickers",
            infoPlist: "Mobile/Stickers/Info.plist",
            sources: ["Mobile/Stickers/Sources/**"],
            resources: ["Mobile/Stickers/Resources/**"],
            entitlements: "Mobile/Stickers/Stickers.entitlements",
            dependencies: [
                .target(name: Shared.Data.target.name(for: .iOS))
            ],
            settings: .settings(
                base: [
                    "ASSETCATALOG_COMPILER_APPICON_NAME": "iMessage App Icon",
                    "ASSETCATALOG_COMPILER_TARGET_STICKERS_ICON_ROLE": "extension",
                ],
                debug: [
                    "CODE_SIGN_IDENTITY": "Apple Development: Buddy Build (D47V8Y25W5)",
                    "PROVISIONING_PROFILE_SPECIFIER": "match Development com.flipbookapp.flickbook.Stickers"
                ],
                release: [
                    "CODE_SIGN_IDENTITY": "Apple Distribution",
                    "PROVISIONING_PROFILE_SPECIFIER": "match AppStore com.flipbookapp.flickbook.Stickers"
                ]
            )
        )
    }
}
