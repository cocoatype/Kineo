//  Created by Geoff Pado on 2/7/20.
//  Copyright © 2020 Cocoatype, LLC. All rights reserved.

import CoreGraphics
import Data
import Foundation

struct ExportSettingsContentProvider {
    var numberOfSections: Int { sections.count }
    func numberOfRows(inSection section: Int) -> Int { sections[section].items.count }
    func item(at indexPath: IndexPath) -> ExportSettingsContentItem { sections[indexPath.section].items[indexPath.row] }
    func section(at index: Int) -> ExportSettingsContentSection { sections[index] }
    func checkedIndexPaths(inSection section: Int) -> [IndexPath] {
        return (0..<sections[section].items.count)
          .map { IndexPath(row: $0, section: section) }
          .filter { item(at: $0).isChecked(for: exportSettings) }
    }

    private var sections: [ExportSettingsContentSection] {
        return [
            ExportSettingsBackgroundContentSection(),
            ExportSettingsDurationContentSection()
        ]
    }

    // MARK: Boilerplate

    private var exportSettings: ExportSettings { Defaults.exportSettings }
}

protocol ExportSettingsContentSection {
    var header: String? { get }
    var footer: String? { get }
    var items: [ExportSettingsContentItem] { get }
}

protocol ExportSettingsContentItem {
    var title: String { get }
    func isChecked(for settings: ExportSettings) -> Bool
    func updateExportSettings()
}
