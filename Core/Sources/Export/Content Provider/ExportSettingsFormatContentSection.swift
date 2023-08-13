//  Created by Geoff Pado on 5/12/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import Data
import Foundation

struct ExportSettingsFormatContentSection: ExportSettingsContentSection {
    init() {
        items = ExportFormat.allCases.map(ExportSettingsFormatContentItem.init)
    }

    let header: String? = NSLocalizedString("ExportSettingsFormatContentSection.header", comment: "Header text for the export format style section")
    let footer: String? = nil
    let items: [ExportSettingsContentItem]
}

struct ExportSettingsFormatContentItem: ExportSettingsContentItem {
    init(format: ExportFormat) {
        self.format = format
    }

    var title: String {
        switch format {
        case .gif: return NSLocalizedString("ExportSettingsFormatContentItem.gif.title", comment: "Title for the animated GIF export format")
        case .video: return NSLocalizedString("ExportSettingsFormatContentItem.video.title", comment: "Title for the video export format")
        }
    }

    var isChecked: Bool {
        return format == Defaults.exportFormat
    }

    func updateExportSettings() {
        Defaults.exportFormat = format
    }

    private let format: ExportFormat
}
