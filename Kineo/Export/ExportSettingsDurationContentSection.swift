//  Created by Geoff Pado on 2/8/20.
//  Copyright © 2020 Cocoatype, LLC. All rights reserved.

import Data
import Foundation

struct ExportSettingsDurationContentSection: ExportSettingsContentSection {
    init() {
        items = ExportDuration.allCases.map(ExportSettingsDurationContentItem.init)
    }

    let header: String? = NSLocalizedString("ExportSettingsDurationContentSection.header", comment: "Header text for the export duration style section")
    let footer: String? = NSLocalizedString("ExportSettingsDurationContentSection.footer", comment: "Footer text for the export duration style section")
    let items: [ExportSettingsContentItem]
}

struct ExportSettingsDurationContentItem: ExportSettingsContentItem {
    init(duration: ExportDuration) {
        self.duration = duration
    }

    var title: String {
        switch duration {
        case .threeSeconds: return NSLocalizedString("ExportSettingsDurationContentItem.threeSeconds.title", comment: "Title for the standard style of export settings")
        case .fiveSeconds: return NSLocalizedString("ExportSettingsDurationContentItem.fiveSeconds.title", comment: "Title for the loop style of export settings")
        case .tenSeconds: return NSLocalizedString("ExportSettingsDurationContentItem.tenSeconds.title", comment: "Title for the bounce style of export settings")
        }
    }

    func isChecked(for settings: ExportSettings) -> Bool {
        return duration == settings.duration
    }

    func updateExportSettings() {
        let newExportSettings = ExportSettings(playbackStyle: Defaults.exportSettings.playbackStyle, duration: duration, shape: Defaults.exportSettings.shape)
        Defaults.exportSettings = newExportSettings
    }

    private let duration: ExportDuration
}

struct ExportSettingsShapeContentSection: ExportSettingsContentSection {
    init() {
        items = ExportShape.allCases.map(ExportSettingsShapeContentItem.init)
    }

    let header: String? = NSLocalizedString("ExportSettingsShapeContentSection.header", comment: "Header text for the export duration style section")
    let footer: String? = nil
    let items: [ExportSettingsContentItem]
}

struct ExportSettingsShapeContentItem: ExportSettingsContentItem {
    init(shape: ExportShape) {
        self.shape = shape
    }

    var title: String {
        switch shape {
        case .squarePlain: return NSLocalizedString("ExportSettingsShapeContentItem.squarePlain.title", comment: "Title for the plain square shape of export settings")
        case .square: return NSLocalizedString("ExportSettingsShapeContentItem.square.title", comment: "Title for the square shape of export settings")
        case .portrait: return NSLocalizedString("ExportSettingsShapeContentItem.portrait.title", comment: "Title for the portrait shape of export settings")
        case .landscape: return NSLocalizedString("ExportSettingsShapeContentItem.landscape.title", comment: "Title for the landscape shape of export settings")
        }
    }

    func isChecked(for settings: ExportSettings) -> Bool {
        return shape == settings.shape
    }

    func updateExportSettings() {
        let newExportSettings = ExportSettings(playbackStyle: Defaults.exportSettings.playbackStyle, duration: Defaults.exportSettings.duration, shape: shape)
        Defaults.exportSettings = newExportSettings
    }

    private let shape: ExportShape
}
