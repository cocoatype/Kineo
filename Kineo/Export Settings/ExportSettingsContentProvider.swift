//  Created by Geoff Pado on 2/7/20.
//  Copyright © 2020 Cocoatype, LLC. All rights reserved.

import CoreGraphics
import Foundation

struct ExportSettingsContentProvider {
    init(_ exportSettings: ExportSettings) {
        self.exportSettings = exportSettings
    }

    var numberOfSections: Int { sections.count }
    func numberOfRows(inSection: Int) -> Int { sections[0].items.count }
    func item(at indexPath: IndexPath) -> ExportSettingsContentItem { sections[indexPath.section].items[indexPath.row] }
    func section(at index: Int) -> ExportSettingsContentSection { sections[index] }

    private var sections: [ExportSettingsContentSection] {
        return [ExportSettingsStyleContentSection(exportSettings)]
    }

    // MARK: Boilerplate

    private let exportSettings: ExportSettings
}

protocol ExportSettingsContentSection {
    var header: String? { get }
    var items: [ExportSettingsContentItem] { get }
}

protocol ExportSettingsContentItem {
    var title: String { get }
    func isChecked(for settings: ExportSettings) -> Bool
}
