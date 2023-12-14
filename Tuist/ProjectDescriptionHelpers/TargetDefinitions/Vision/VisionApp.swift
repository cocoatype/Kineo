import ProjectDescription

public extension Vision {
    enum App {
        public static let target = Target(
            name: "VisionApp",
            platform: .visionOS,
            product: .app,
            bundleId: "com.flipbookapp.flickbook",
            infoPlist: "Vision/App/Info.plist",
            sources: ["Vision/App/Sources/**"],
            resources: ["Vision/App/Resources/**"],
            dependencies: [
                .target(name: Vision.ExportEditing.target.name),
                .target(name: Vision.FilmStrip.target.name),
                .target(name: Vision.Playback.target.name),
                .target(name: Vision.Toolbar.target.name),
                .target(name: Shared.Canvas.target.name(for: .visionOS)),
                .target(name: Shared.Export.target.name(for: .visionOS)),
                .external(name: "SwiftUIIntrospect"),
            ],
            settings: .settings(
                base: [
                    "GENERATE_INFOPLIST_FILE": "YES",
                    "LD_RUNPATH_SEARCH_PATHS": ["$(inherited)", "@executable_path/Frameworks"],
                    "PRODUCT_NAME": "Kineo",
                ]
            )
        )
    }
}