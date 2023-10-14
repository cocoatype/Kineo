import ProjectDescription

public struct MultiPlatformTarget: TargetProducer {
    private let name: String
    private let platforms: [Platform]
    private let product: Product
    private let productName: String?
    private let bundleId: String
    private let deploymentTarget: DeploymentTarget?
    private let infoPlist: InfoPlist?
    private let sources: SourceFilesList?
    private let resources: ResourceFileElements?
    private let copyFiles: [CopyFilesAction]?
    private let headers: Headers?
    private let entitlements: Entitlements?
    private let scripts: [TargetScript]
    private let dependencies: [MultiPlatformDependency]
    private let settings: Settings?
    private let coreDataModels: [CoreDataModel]
    private let environmentVariables: [String: EnvironmentVariable]
    private let launchArguments: [LaunchArgument]
    private let additionalFiles: [FileElement]
    private let buildRules: [BuildRule]

    public init(
        name: String,
        platforms: [Platform],
        product: Product,
        productName: String? = nil,
        bundleId: String,
        deploymentTarget: DeploymentTarget? = nil,
        infoPlist: InfoPlist? = .default,
        sources: SourceFilesList? = nil,
        resources: ResourceFileElements? = nil,
        copyFiles: [CopyFilesAction]? = nil,
        headers: Headers? = nil,
        entitlements: Entitlements? = nil,
        scripts: [TargetScript] = [],
        dependencies: [MultiPlatformDependency] = [],
        settings: Settings? = nil,
        coreDataModels: [CoreDataModel] = [],
        environmentVariables: [String : EnvironmentVariable] = [:],
        launchArguments: [LaunchArgument] = [],
        additionalFiles: [FileElement] = [],
        buildRules: [BuildRule] = []
    ) {
        self.name = name
        self.platforms = platforms
        self.product = product
        self.productName = productName
        self.bundleId = bundleId
        self.deploymentTarget = deploymentTarget
        self.infoPlist = infoPlist
        self.sources = sources
        self.resources = resources
        self.copyFiles = copyFiles
        self.headers = headers
        self.entitlements = entitlements
        self.scripts = scripts
        self.dependencies = dependencies
        self.settings = settings
        self.coreDataModels = coreDataModels
        self.environmentVariables = environmentVariables
        self.launchArguments = launchArguments
        self.additionalFiles = additionalFiles
        self.buildRules = buildRules
    }

    public var targets: [Target] {
        platforms.map { platform in
            Target(
                name: name + platform.nameSuffix,
                platform: platform,
                product: product,
                productName: productName,
                bundleId: bundleId,
                deploymentTarget: deploymentTarget,
                infoPlist: infoPlist,
                sources: sources,
                resources: resources,
                copyFiles: copyFiles,
                headers: headers,
                entitlements: entitlements,
                scripts: scripts,
                dependencies: dependencies.map { $0.targetDependency(for: platform) },
                settings: settings,
                coreDataModels: coreDataModels,
                environmentVariables: environmentVariables,
                launchArguments: launchArguments,
                additionalFiles: additionalFiles,
                buildRules: buildRules
            )
        }
    }
}

public enum MultiPlatformDependency {
    case multiPlatformTarget(namePrefix: String)
    case target(name: String)
    case external(name: String)

    func targetDependency(for platform: Platform) -> TargetDependency {
        switch self {
        case .multiPlatformTarget(let namePrefix):
            return .target(name: namePrefix + platform.nameSuffix)
        case .target(let name):
            return .target(name: name)
        case .external(let name):
            return .external(name: name)
        }
    }
}

private extension Platform {
    var nameSuffix: String {
        switch self {
        case .iOS: return "Phone"
        case .macOS: return "Mac"
        case .watchOS: return "Watch"
        case .tvOS: return "TV"
        case .visionOS: return "Vision"
        @unknown default: return ""
        }
    }
}
