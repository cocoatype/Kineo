import ProjectDescription

public extension Mobile {
    enum Core {
        public static let target = Target(
            name: "Core",
            platform: .iOS,
            product: .framework,
            bundleId: "com.flipbookapp.flickbook.Core",
            sources: ["Core/Sources/**"],
            dependencies: [
                .external(name: "Introspect"),
                .external(name: "Lottie"),
                .target(name: Shared.Canvas.target.name(for: .iOS)),
                .target(name: Shared.Data.target.name(for: .iOS)),
                .target(name: Shared.DocumentNavigation.target.name(for: .iOS)),
                .target(name: Shared.EditingState.target.name(for: .iOS)),
                .target(name: Shared.Export.target.name(for: .iOS)),
                .target(name: Mobile.FilmStrip.target.name),
            ]
        )
    }
}
