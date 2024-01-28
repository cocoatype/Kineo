import ProjectDescription

public extension Shared {
    enum Onboarding {
        public static let target = MultiPlatformTarget(
            name: "Onboarding",
            platforms: [.iOS, .visionOS],
            product: .framework,
            bundleId: "com.flipbookapp.flickbook.Onboarding",
            sources: ["Shared/Onboarding/Sources/**"],
            dependencies: [
                .multiPlatformTarget(namePrefix: Shared.Data.target.namePrefix),
                .multiPlatformTarget(namePrefix: Shared.Style.target.namePrefix),
            ],
            settings: .settings(
                base: [
                    "APPLICATION_EXTENSION_API_ONLY": "YES"
                ]
            )
        )
    }
}
