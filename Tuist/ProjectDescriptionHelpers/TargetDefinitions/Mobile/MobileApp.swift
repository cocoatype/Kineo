import ProjectDescription

public extension Mobile {
    enum App {
        public static let target = Target(
            name: "Kineo",
            platform: .iOS,
            product: .app,
            bundleId: "com.flipbookapp.flickbook",
            infoPlist: "App/Info.plist",
            sources: ["App/Sources/**"],
            resources: ["App/Resources/**"],
            entitlements: "App/Kineo.entitlements",
            dependencies: [
                .target(name: Mobile.Clip.target.name),
                .target(name: "Core"),
                .target(name: "DataPhone"),
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
        )

        public static let testTarget = Target(
            name: "Tests",
            platform: .iOS,
            product: .unitTests,
            bundleId: "com.flipbookapp.flickbook.Tests",
            infoPlist: "Tests/Info.plist",
            sources: ["Tests/Sources/**"]
        )
    }
}
