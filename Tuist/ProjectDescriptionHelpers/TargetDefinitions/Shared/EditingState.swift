import ProjectDescription

public extension Shared {
    enum EditingState {
        public static let target = MultiPlatformTarget(
            name: "EditingState",
            platforms: [.iOS, .visionOS],
            product: .framework,
            bundleId: "com.flipbookapp.flickbook.EditingState",
            sources: ["EditingState/Sources/**"],
            dependencies: [
                .multiPlatformTarget(namePrefix: Shared.Data.target.namePrefix),
                .multiPlatformTarget(namePrefix: Shared.DocumentNavigation.target.namePrefix)
            ]
        )
    }
}
