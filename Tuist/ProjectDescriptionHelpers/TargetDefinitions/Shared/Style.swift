import ProjectDescription

public extension Shared {
    enum Style {
        public static let target = MultiPlatformTarget(
            name: "Style",
            platforms: [.iOS, .visionOS],
            product: .framework,
            bundleId: "com.flipbookapp.flickbook.Style",
            sources: ["Style/Sources/**"],
            resources: ["Style/Resources/**"],
            settings: .settings(
                base: [
                    "APPLICATION_EXTENSION_API_ONLY": "YES"
                ]
            )
        )
    }
}
