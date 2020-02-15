//  Created by Geoff Pado on 2/8/20.
//  Copyright © 2020 Cocoatype, LLC. All rights reserved.

import Foundation

enum Defaults {
    static func initialize() {
        userDefaults.register(defaults: [
            Self.exportPlaybackStyleKey: Self.exportPlaybackStyleLoop,
            Self.exportDurationKey: Self.exportDurationThreeSeconds
        ])
    }

    private static let userDefaults: UserDefaults = {
        guard let defaults = UserDefaults(suiteName: "group.com.flipbookapp.flickbook") else { fatalError("Unable to create user defaults") }
        return defaults
    }()

    // MARK: Export Settings

    static var exportSettings: ExportSettings { ExportSettings(playbackStyle: exportPlaybackStyle, duration: exportDuration) }

    private static var exportPlaybackStyle: PlaybackStyle {
        switch userDefaults.string(forKey: Self.exportPlaybackStyleKey) {
        case Self.exportPlaybackStyleStandard?: return .standard
        case Self.exportPlaybackStyleLoop?: return .loop
        case Self.exportPlaybackStyleBounce?: return .bounce
        default: return .loop
        }
    }

    private static var exportDuration: ExportDuration {
        switch userDefaults.string(forKey: Self.exportDurationKey) {
        case Self.exportDurationThreeSeconds?: return .threeSeconds
        case Self.exportDurationFiveSeconds?: return .fiveSeconds
        case Self.exportDurationTenSeconds?: return .tenSeconds
        default: return .threeSeconds
        }
    }

    // MARK: Keys and Values

    private static let exportPlaybackStyleKey = "Defaults.exportPlaybackStyle"
    private static let exportPlaybackStyleStandard = "Defaults.exportPlaybackStyleStandard"
    private static let exportPlaybackStyleLoop = "Defaults.exportPlaybackStyleLoop"
    private static let exportPlaybackStyleBounce = "Defaults.exportPlaybackStyleBounce"
    private static let exportDurationKey = "Defaults.exportDuration"
    private static let exportDurationThreeSeconds = "Defaults.exportDurationThreeSeconds"
    private static let exportDurationFiveSeconds = "Defaults.exportDurationFiveSeconds"
    private static let exportDurationTenSeconds = "Defaults.exportDurationTenSeconds"
}
