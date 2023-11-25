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
  settings: .settings(
    base: [
      "CURRENT_PROJECT_VERSION": "0",
      "DEVELOPMENT_TEAM": "287EDDET2B",
      "IPHONEOS_DEPLOYMENT_TARGET": "16.0",
      "MARKETING_VERSION": "23.0",
    ],
    debug: [
      "CODE_SIGN_IDENTITY": "Apple Development: Buddy Build (D47V8Y25W5)"
    ]
  ),
  targets: targets,
  schemes: [
    Scheme(
      name: "Kineo",
      shared: true,
      buildAction: .buildAction(targets: ["Kineo"]),
      testAction: .targets(["Tests"]),
      runAction: .runAction(
        executable: "Kineo",
        arguments: Arguments(
            environmentVariables: FeatureFlags.environment
        )
      )
    )
  ]
)
