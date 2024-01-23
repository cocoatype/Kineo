import ProjectDescription

public extension Shared {
    enum Purchasing {
        public static let target = MultiPlatformTarget(
            name: "Purchasing",
            platforms: [.iOS, .visionOS],
            product: .framework,
            bundleId: "com.flipbookapp.flickbook.Purchasing",
            sources: ["Shared/Purchasing/Sources/**"],
            dependencies: [
                .multiPlatformTarget(namePrefix: Shared.Data.target.namePrefix),
//                .multiPlatformTarget(namePrefix: Shared.Style.target.namePrefix),
//                .external(name: "Introspect"),
            ]
        )
    }
}
