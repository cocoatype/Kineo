import ProjectDescription

public extension Shared {
    enum DocumentNavigation {
        public static let target = MultiPlatformTarget(
            name: "DocumentNavigation",
            platforms: [.iOS, .visionOS],
            product: .framework,
            bundleId: "com.flipbookapp.flickbook.DocumentNavigation",
            sources: ["Shared/DocumentNavigation/Sources/**"],
            dependencies: []
        )
    }
}
