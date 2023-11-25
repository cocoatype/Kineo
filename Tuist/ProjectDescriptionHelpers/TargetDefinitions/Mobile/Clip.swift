import ProjectDescription

public extension Mobile {
    enum Clip {
        public static let target = Target(
            name: "Clip",
            platform: .iOS,
            product: .appClip,
            bundleId: "com.flipbookapp.flickbook.Clip",
            infoPlist: "Clip/Info.plist",
            sources: ["Clip/Sources/**"],
            resources: ["App/Resources/**"],
            entitlements: "Clip/Clip.entitlements",
            dependencies: [
                .target(name: Mobile.Core.target.name),
                .target(name: Shared.Data.target.name(for: .iOS)),
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
        )
    }
}
