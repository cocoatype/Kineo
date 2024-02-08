import ProjectDescription

let dependencies = Dependencies(
  swiftPackageManager: [
    .remote(url: "https://github.com/siteline/SwiftUI-Introspect.git", requirement: .exact("0.12.0")),
    .remote(url: "https://github.com/airbnb/lottie-ios.git", requirement: .upToNextMajor(from: "3.2.1")),
    .remote(url: "https://github.com/TelemetryDeck/SwiftClient", requirement: .upToNextMajor(from: "1.5.1")),
  ]
)
