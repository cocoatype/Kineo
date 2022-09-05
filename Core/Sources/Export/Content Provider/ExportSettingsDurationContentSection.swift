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

    var isChecked: Bool {
        return duration == Defaults.exportDuration
    }

    func updateExportSettings() {
        Defaults.exportDuration = duration
    }

    private let duration: ExportDuration
}
