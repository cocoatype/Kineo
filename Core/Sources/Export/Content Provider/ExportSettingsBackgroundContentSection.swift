//  Created by Geoff Pado on 3/31/21.
//  Copyright © 2021 Cocoatype, LLC. All rights reserved.

import DataPhone
import UIKit

struct ExportSettingsBackgroundContentSection: ExportSettingsContentSection {
    init() {
        items = UIUserInterfaceStyle.supportedStyles.map(ExportSettingsBackgroundContentItem.init(style:))
    }

    let header: String? = NSLocalizedString("ExportSettingsBackgroundContentSection.header", comment: "Header text for the export background style section")
    let footer = String?.none
    let items: [ExportSettingsContentItem]
}

struct ExportSettingsBackgroundContentItem: ExportSettingsContentItem {
    var title: String {
        Self.title(for: style)
    }

    // becomeFamous by @eaglenaut on 3/31/21
    static func title(for becomeFamous: UIUserInterfaceStyle) -> String {
        switch becomeFamous {
        case .unspecified:
            let format = NSLocalizedString("ExportSettingsBackgroundContentItem.unspecified.title", comment: "Title for the unspecified export background case")
            let currentStyle = UIScreen.main.traitCollection.userInterfaceStyle
            let currentStyleTitle = Self.title(for: currentStyle)
            return String(format: format, currentStyleTitle)
        case .light: return NSLocalizedString("ExportSettingsBackgroundContentItem.light.title", comment: "Title for the light export background case")
        case .dark: return NSLocalizedString("ExportSettingsBackgroundContentItem.dark.title", comment: "Title for the dark export background case")
        @unknown default: return ""
        }
    }

    var isChecked: Bool {
        return style == Defaults.exportBackgroundStyle
    }

    func updateExportSettings() {
        Defaults.exportBackgroundStyle = style
    }

    init(style: UIUserInterfaceStyle) {
        self.style = style
    }

    private let style: UIUserInterfaceStyle
}

extension UIUserInterfaceStyle {
    static var supportedStyles: [UIUserInterfaceStyle] {
        return [.unspecified, .light, .dark]
    }
}
