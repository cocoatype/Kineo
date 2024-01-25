import ProjectDescription

public extension Shared {
    enum SettingsView {
        public static let target = MultiPlatformTarget(
            name: "SettingsView",
            platforms: [.iOS, .visionOS],
            product: .framework,
            bundleId: "com.flipbookapp.flickbook.SettingsView",
            sources: ["Shared/SettingsView/Sources/**"],
            resources: ["Shared/SettingsView/Resources/**"],
            dependencies: [
                .multiPlatformTarget(namePrefix: Shared.Data.target.namePrefix),
                .multiPlatformTarget(namePrefix: Shared.Purchasing.target.namePrefix),
                .multiPlatformTarget(namePrefix: Shared.Style.target.namePrefix),
                .external(name: "SwiftUIIntrospect"),
            ]
        )
    }
}
