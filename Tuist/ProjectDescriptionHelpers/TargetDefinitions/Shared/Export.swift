import ProjectDescription

public extension Shared {
    enum Export {
        public static let target = MultiPlatformTarget(
            name: "Export",
            platforms: [.iOS, .visionOS],
            product: .framework,
            bundleId: "com.flipbookapp.flickbook.Export",
            sources: ["Export/Sources/**"],
            dependencies: [
                .multiPlatformTarget(namePrefix: Shared.Data.target.namePrefix),
            ]
        )
    }
}
