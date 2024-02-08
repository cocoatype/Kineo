import ProjectDescription

public extension Shared {
    enum Telemetry {
        public static let target = MultiPlatformTarget(
            name: "Telemetry",
            platforms: [.iOS, .visionOS],
            product: .framework,
            bundleId: "com.flipbookapp.flickbook.Telemetry",
            sources: ["Shared/Telemetry/Sources/**"],
            dependencies: [
                .external(name: "TelemetryClient"),
            ],
            settings: .settings(
                base: [
                    "APPLICATION_EXTENSION_API_ONLY": "YES"
                ]
            )
        )
    }
}
