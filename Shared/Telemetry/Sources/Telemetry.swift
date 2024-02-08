import TelemetryClient

public enum Telemetry {
    public static func initialize() {
        let configuration = TelemetryManagerConfiguration(appID: "002A67B1-AB0E-4CA8-B708-3671809041CF")
        TelemetryManager.initialize(with: configuration)
        TelemetryManager.send("telemetryInitialized")
    }
}
