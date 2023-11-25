import ProjectDescription

public extension Vision {
    enum Playback {
        public static let target = Target(
            name: "PlaybackVision",
            platform: .visionOS,
            product: .framework,
            bundleId: "com.flipbookapp.flickbook.Playback",
            sources: ["Vision/Playback/Sources/**"],
            dependencies: [
                .target(name: Shared.Data.target.name(for: .visionOS)),
                .target(name: Shared.EditingState.target.name(for: .visionOS)),
            ]
        )
    }
}
