import ProjectDescription

public extension Vision {
    enum Toolbar {
        public static let target = Target(
            name: "ToolbarVision",
            platform: .visionOS,
            product: .framework,
            bundleId: "com.flipbookapp.flickbook.Toolbar",
            sources: ["Vision/Toolbar/Sources/**"],
            dependencies: [
                .target(name: Vision.ExportEditing.target.name),
                .target(name: Shared.EditingState.target.name(for: .visionOS)),
            ]
        )
    }
}
