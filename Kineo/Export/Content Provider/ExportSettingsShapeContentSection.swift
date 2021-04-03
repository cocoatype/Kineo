//  Created by Geoff Pado on 3/31/21.
//  Copyright © 2021 Cocoatype, LLC. All rights reserved.

import Data
import Foundation

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
