import ProjectDescription

public extension Mobile {
    enum FilmStrip {
        public static let target = Target(
            name: "FilmStripPhone",
            platform: .iOS,
            product: .framework,
            bundleId: "com.flipbookapp.flickbook.FilmStrip",
            sources: ["FilmStrip/Sources/**"],
            dependencies: [
                .target(name: Shared.EditingState.target.name(for: .iOS))
            ]
        )
    }
}
