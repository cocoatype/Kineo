import ProjectDescription

public extension Vision {
    enum ExportEditing {
        public static let target = Target(
            name: "ExportEditingVision",
            platform: .visionOS,
            product: .framework,
            bundleId: "com.flipbookapp.flickbook.ExportEditing",
            sources: ["Vision/ExportEditing/Sources/**"],
            dependencies: [
                .target(name: Shared.EditingState.target.name(for: .visionOS)),
            ]
        )
    }
}
