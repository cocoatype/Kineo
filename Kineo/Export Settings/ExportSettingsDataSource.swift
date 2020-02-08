//  Created by Geoff Pado on 2/8/20.
//  Copyright © 2020 Cocoatype, LLC. All rights reserved.

import UIKit

class ExportSettingsDataSource: NSObject, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        contentProvider.numberOfSections
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        contentProvider.numberOfRows(inSection: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ExportSettingsTableViewCell.identifier, for: indexPath)

        let item = contentProvider.item(at: indexPath)
        cell.textLabel?.text = item.title
        cell.accessoryType = item.isChecked(for: Defaults.exportSettings) ? .checkmark : .none

        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        contentProvider.section(at: section).header
    }

    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        contentProvider.section(at: section).footer
    }

    private let contentProvider = ExportSettingsContentProvider(Defaults.exportSettings)
}
