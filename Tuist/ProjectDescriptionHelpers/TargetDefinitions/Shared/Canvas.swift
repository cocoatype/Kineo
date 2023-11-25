import ProjectDescription

public extension Shared {
    enum Canvas {
        public static let target = MultiPlatformTarget(
            name: "Canvas",
            platforms: [.iOS, .visionOS],
            product: .framework,
            bundleId: "com.flipbookapp.flickbook.Canvas",
            sources: ["Canvas/Sources/**"],
            dependencies: [
                .multiPlatformTarget(namePrefix: Data.target.namePrefix),
                .multiPlatformTarget(namePrefix: DocumentNavigation.target.namePrefix),
                .multiPlatformTarget(namePrefix: EditingState.target.namePrefix),
            ]
        )
    }
}
