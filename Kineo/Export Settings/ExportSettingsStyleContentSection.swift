//  Created by Geoff Pado on 2/8/20.
//  Copyright © 2020 Cocoatype, LLC. All rights reserved.

import Foundation

struct ExportSettingsStyleContentSection: ExportSettingsContentSection {
    init(_ exportSettings: ExportSettings) {
        items = ExportSettingsStyleContentItem.allCases
    }

    let header: String? = NSLocalizedString("ExportSettingsStyleContentSection.header", comment: "Header text for the export settings style section")
    let items: [ExportSettingsContentItem]
}

enum ExportSettingsStyleContentItem: ExportSettingsContentItem, CaseIterable {
    case standard
    case loop
    case bounce

    var title: String {
        switch self {
        case .standard: return NSLocalizedString("ExportSettingsStyleContentItem.standard.title", comment: "Title for the standard style of export settings")
        case .loop: return NSLocalizedString("ExportSettingsStyleContentItem.loop.title", comment: "Title for the loop style of export settings")
        case .bounce: return NSLocalizedString("ExportSettingsStyleContentItem.bounce.title", comment: "Title for the bounce style of export settings")
        }
    }

    func isChecked(for settings: ExportSettings) -> Bool {
        return true
    }
}
