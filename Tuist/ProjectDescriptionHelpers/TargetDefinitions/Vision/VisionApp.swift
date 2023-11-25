import ProjectDescription

public extension Vision {
    enum App {
        public static let target = Target(
            name: "KineoVision",
            platform: .visionOS,
            product: .app,
            bundleId: "com.flipbookapp.flickbook",
            infoPlist: "KineoVision/Info.plist",
            sources: ["KineoVision/Sources/**"],
            resources: ["KineoVision/Resources/**"],
            dependencies: [
                .target(name: Shared.Canvas.target.name(for: .visionOS)),
                .target(name: Shared.Export.target.name(for: .visionOS)),
                .external(name: "SwiftUIIntrospect"),
            ],
            settings: .settings(
                base: [
                    "GENERATE_INFOPLIST_FILE": "YES",
                    "LD_RUNPATH_SEARCH_PATHS": ["$(inherited)", "@executable_path/Frameworks"],
                ]
            )
        )
    }
}
