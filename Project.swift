import ProjectDescription
import ProjectDescriptionHelpers

let targets = ([
    Mobile.App.target,
    Mobile.App.testTarget,
    Mobile.Clip.target,
    Mobile.Core.target,
    Mobile.FilmStrip.target,
    Mobile.Stickers.target,

    Vision.App.target,
    Vision.ExportEditing.target,
    Vision.FilmStrip.target,
    Vision.Playback.target,
    Vision.Toolbar.target,

    Shared.Canvas.target,
    Shared.Data.target,
    Shared.Data.testTarget,
    Shared.DocumentNavigation.target,
    Shared.EditingState.target,
    Shared.Export.target,
    Shared.Style.target,
] as [TargetProducer]).flatMap(\.targets)

let project = Project(
  name: "Kineo",
  organizationName: "Cocoatype, LLC",
  options: .options(automaticSchemesOptions: .disabled),
  settings: .settings(
    base: [
      "CURRENT_PROJECT_VERSION": "0",
      "DEVELOPMENT_TEAM": "287EDDET2B",
      "IPHONEOS_DEPLOYMENT_TARGET": "16.0",
    ],
    debug: [
      "CODE_SIGN_IDENTITY": "Apple Development: Buddy Build (D47V8Y25W5)"
    ]
  ),
  targets: targets,
  schemes: [
    Scheme(
      name: "Kineo (iOS)",
      shared: true,
      buildAction: .buildAction(targets: ["MobileApp"]),
      testAction: .targets(["MobileAppTests"]),
      runAction: .runAction(
        executable: "MobileApp",
        arguments: Arguments(
            environmentVariables: FeatureFlags.environment
        )
      )
    ),
    Scheme(
      name: "Kineo (visionOS)",
      shared: true,
      buildAction: .buildAction(targets: ["VisionApp"]),
      runAction: .runAction(
        executable: "VisionApp",
        arguments: Arguments(
            environmentVariables: FeatureFlags.environment
        )
      )
    ),
  ]
)
