//  Created by Geoff Pado on 2/8/20.
//  Copyright © 2020 Cocoatype, LLC. All rights reserved.

import CloudKit
import Foundation
import UIKit

public enum Defaults {
    public static func initialize() {
        userDefaults.register(defaults: [
            Self.exportPlaybackStyleKey: Self.exportPlaybackStyleLoop,
            Self.exportDurationKey: Self.exportDurationThreeSeconds,
            Self.seenTutorialKey: false
        ])
    }

    private static let userDefaults: UserDefaults = {
        guard let defaults = UserDefaults(suiteName: "group.com.flipbookapp.flickbook") else { fatalError("Unable to create user defaults") }
        return defaults
    }()

    // MARK: Export Settings

    public static var exportSettings: ExportSettings {
        get { ExportSettings(playbackStyle: exportPlaybackStyle, duration: exportDuration, shape: exportShape) }
        set(newSettings) {
            Self.exportPlaybackStyle = newSettings.playbackStyle
            Self.exportDuration = newSettings.duration
            Self.exportShape = newSettings.shape
        }
    }

    public static var exportPlaybackStyle: PlaybackStyle {
        get {
            switch userDefaults.string(forKey: Self.exportPlaybackStyleKey) {
            case Self.exportPlaybackStyleStandard?: return .standard
            case Self.exportPlaybackStyleLoop?: return .loop
            case Self.exportPlaybackStyleBounce?: return .bounce
            default: return .loop
            }
        } set(newStyle) {
            switch newStyle {
            case .standard: userDefaults.set(Self.exportPlaybackStyleStandard, forKey: Self.exportPlaybackStyleKey)
            case .loop: userDefaults.set(Self.exportPlaybackStyleLoop, forKey: Self.exportPlaybackStyleKey)
            case .bounce: userDefaults.set(Self.exportPlaybackStyleBounce, forKey: Self.exportPlaybackStyleKey)
            }
        }
    }

    private static var exportDuration: ExportDuration {
        get {
            switch userDefaults.string(forKey: Self.exportDurationKey) {
            case Self.exportDurationThreeSeconds?: return .threeSeconds
            case Self.exportDurationFiveSeconds?: return .fiveSeconds
            case Self.exportDurationTenSeconds?: return .tenSeconds
            default: return .threeSeconds
            }
        } set (newDuration) {
            switch newDuration {
            case .threeSeconds: userDefaults.set(exportDurationThreeSeconds, forKey: exportDurationKey)
            case .fiveSeconds: userDefaults.set(exportDurationFiveSeconds, forKey: exportDurationKey)
            case .tenSeconds: userDefaults.set(exportDurationTenSeconds, forKey: exportDurationKey)
            }
        }
    }

    public static var exportShape: ExportShape {
        get {
            switch userDefaults.string(forKey: exportShapeKey) {
            case Self.exportShapeSquare?: return .square
            case Self.exportShapeSquarePlain?: return .squarePlain
            case Self.exportShapePortrait?: return .portrait
            case Self.exportShapeLandscape?: return .landscape
            default: return .square
            }
        } set (newShape) {
            let value: String
            switch newShape {
            case .square: value = exportShapeSquare
            case .squarePlain: value = exportShapeSquarePlain
            case .portrait: value = exportShapePortrait
            case .landscape: value = exportShapeLandscape
            }
            userDefaults.set(value, forKey: exportShapeKey)
        }
    }

    public static var exportBackgroundStyle: UIUserInterfaceStyle {
        get {
            switch userDefaults.string(forKey: exportBackgroundKey) {
            case Self.exportBackgroundUnspecified?: return .unspecified
            case Self.exportBackgroundLight: return .light
            case Self.exportBackgroundDark?: return .dark
            default: return .unspecified
            }
        } set (newStyle) {
            let value: String
            switch newStyle {
            case .unspecified: value = exportBackgroundUnspecified
            case .light: value = exportBackgroundLight
            case .dark: value = exportBackgroundDark
            @unknown default: value = exportBackgroundUnspecified
            }
            userDefaults.set(value, forKey: exportBackgroundKey)
        }
    }

    public static var exportHideWatermark: Bool {
        get {
            userDefaults.bool(forKey: Self.exportHideWatermarkKey)
        } set (newValue) {
            userDefaults.set(newValue, forKey: Self.exportHideWatermarkKey)
        }
    }

    // MARK: Cloud

    static private(set) var updatedDocumentIdentifiers: [UUID] {
        get {
            return userDefaults.stringArray(forKey: updatedDocumentIdentifiersKey)?.compactMap(UUID.init(uuidString:)) ?? []
        } set(newIdentifiers) {
            userDefaults.set(newIdentifiers.map { $0.uuidString }, forKey: updatedDocumentIdentifiersKey)
        }
    }

    static func addUpdatedDocumentIdentifier(_ identifier: UUID) {
        updatedDocumentIdentifiers = updatedDocumentIdentifiers + [identifier]
    }

    static func removeUpdatedDocumentIdentifiers(_ identifiers: [UUID]) {
        updatedDocumentIdentifiers = updatedDocumentIdentifiers.filter { identifiers.contains($0) == false }
    }

    static var serverChangeToken: CKServerChangeToken? {
        get {
            guard let serverChangeTokenData = userDefaults.data(forKey: serverChangeTokenDataKey) else { return nil }
            return try? NSKeyedUnarchiver.unarchivedObject(ofClass: CKServerChangeToken.self, from: serverChangeTokenData)
        } set(newChangeToken) {
            guard let token = newChangeToken, let data = try? NSKeyedArchiver.archivedData(withRootObject: token, requiringSecureCoding: true) else { return }
            userDefaults.set(data, forKey: serverChangeTokenDataKey)
        }
    }

    // MARK: Tutorial

    public static var seenTutorial: Bool {
        get { return userDefaults.bool(forKey: Self.seenTutorialKey) }
        set(newSeenTutorial) {
            userDefaults.set(newSeenTutorial, forKey: Self.seenTutorialKey)
        }
    }

    // MARK: Saves

    private(set) public static var numberOfSaves: Int {
        get {
            return userDefaults.integer(forKey: Self.numberOfSavesKey)
        } set(newNumberOfSaves) {
            userDefaults.set(newNumberOfSaves, forKey: Self.numberOfSavesKey)
        }
    }

    public static func incrementNumberOfSaves() {
        numberOfSaves += 1
    }

    // MARK: Purchasing

    public static func enablePurchasedSettings() {
        exportHideWatermark = true
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
    private static let exportShapeKey = "Defaults.exportShape"
    private static let exportShapeSquare = "Defaults.exportShapeSquare"
    private static let exportShapeSquarePlain = "Defaults.exportShapeSquarePlain"
    private static let exportShapePortrait = "Defaults.exportShapePortrait"
    private static let exportShapeLandscape = "Defaults.exportShapeLandscape"
    private static let exportBackgroundKey = "Defaults.exportBackground"
    private static let exportBackgroundUnspecified = "Defaults.exportBackgroundUnspecified"
    private static let exportBackgroundLight = "Defaults.exportBackgroundLight"
    private static let exportBackgroundDark = "Defaults.exportBackgroundDark"
    private static let exportHideWatermarkKey = "Defaults.exportHideWatermarkKey"
    private static let serverChangeTokenDataKey = "Defaults.serverChangeTokenDataKey"
    private static let updatedDocumentIdentifiersKey = "Defaults.updatedDocumentIdentifiersKey"
    private static let seenTutorialKey = "Defaults.seenTutorialKey"
    private static let numberOfSavesKey = "Defaults.numberOfSavesKey"
}
