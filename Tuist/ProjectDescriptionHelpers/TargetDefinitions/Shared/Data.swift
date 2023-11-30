import ProjectDescription

public extension Shared {
    enum Data {
        public static let target = MultiPlatformTarget(
            name: "Data",
            platforms: [.iOS, .visionOS],
            product: .framework,
            bundleId: "com.flipbookapp.flickbook.Data",
            infoPlist: "Shared/Data/Info.plist",
            sources: ["Shared/Data/Sources/**"],
            headers: .headers(
                public: ["Sources/Data.h"]
            ),
            dependencies: [
                .multiPlatformTarget(namePrefix: Shared.Style.target.namePrefix),
            ],
            settings: .settings(
                base: [
                    "APPLICATION_EXTENSION_API_ONLY": "YES"
                ]
            )
        )

        public static let testTarget = MultiPlatformTarget(
            name: "DataTests",
            platforms: [.iOS, .visionOS],
            product: .unitTests,
            bundleId: "com.flipbookapp.flickbook.DataTests",
            sources: ["Shared/Data/Tests/**"],
            dependencies: [
                .multiPlatformTarget(namePrefix: target.namePrefix)
            ]
        )
    }
}
