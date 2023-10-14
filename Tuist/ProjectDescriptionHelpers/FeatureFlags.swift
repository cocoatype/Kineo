import ProjectDescription

public enum FeatureFlags: String, CaseIterable {
    case displayMode = "FF_DISPLAY_MODE"
    case newFilmStrip = "FF_NEW_FILM_STRIP"

    public static var environment: [String: EnvironmentVariable] {
        Dictionary(uniqueKeysWithValues: allCases.map { flag in
            (flag.rawValue, EnvironmentVariable(value: "1", isEnabled: false))
        })
    }
}
