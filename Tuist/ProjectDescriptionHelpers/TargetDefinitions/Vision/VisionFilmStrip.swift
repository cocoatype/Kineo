import ProjectDescription

public extension Vision {
    enum FilmStrip {
        public static let target = Target(
            name: "FilmStripVision",
            platform: .visionOS,
            product: .framework,
            bundleId: "com.flipbookapp.flickbook.FilmStrip",
            sources: ["Vision/FilmStrip/Sources/**"],
            dependencies: [
                .target(name: Shared.Data.target.name(for: .visionOS)),
                .target(name: Shared.EditingState.target.name(for: .visionOS)),
                .external(name: "SwiftUIIntrospect"),
            ]
        )
    }
}
