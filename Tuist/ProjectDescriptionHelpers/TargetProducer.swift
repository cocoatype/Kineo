import ProjectDescription

public protocol TargetProducer {
    var targets: [Target] { get }
}

extension Target: TargetProducer {
    public var targets: [Target] { return [self] }
}
