import ProjectDescription

public extension Mobile {
    enum App {
        public static let target = Target(
            name: "MobileApp",
            platform: .iOS,
            product: .app,
            bundleId: "com.flipbookapp.flickbook",
            infoPlist: "Mobile/App/Info.plist",
            sources: ["Mobile/App/Sources/**"],
            resources: ["Mobile/App/Resources/**"],
            entitlements: "Mobile/App/Kineo.entitlements",
            dependencies: [
                .target(name: Mobile.Clip.target.name),
                .target(name: "Core"),
                .target(name: "DataPhone"),
                .target(name: "Stickers")
            ],
            settings: .settings(
                base: [
                    "PRODUCT_NAME": "Kineo",
                ],
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
            name: "MobileAppTests",
            platform: .iOS,
            product: .unitTests,
            bundleId: "com.flipbookapp.flickbook.Tests",
            infoPlist: "Mobile/Tests/Info.plist",
            sources: ["Mobile/Tests/Sources/**"]
        )
    }
}
