import ProjectDescription

let dependencies = Dependencies(
  swiftPackageManager: [
    .remote(url: "https://github.com/siteline/SwiftUI-Introspect.git", requirement: .exact("0.1.4")),
    .remote(url: "https://github.com/airbnb/lottie-ios.git", requirement: .upToNextMajor(from: "3.2.1"))
  ]
)
