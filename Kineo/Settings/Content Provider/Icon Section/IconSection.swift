//  Created by Geoff Pado on 3/6/20.
//  Copyright © 2020 Cocoatype, LLC. All rights reserved.

import UIKit

protocol SwitchableContentItem {
    var isOn: Bool { get }
}

struct IconSection: SettingsContentSection {
    let header = String?.none
    let items: [SettingsContentItem] = [
        UseLegacyIconItem()
    ]
}

struct UseLegacyIconItem: SettingsContentItem, SwitchableContentItem {
    let title = NSLocalizedString("UseLegacyIconItem.title", comment: "Title for the settings row to use the legacy icon")
    let subtitle = String?.none

    var isOn: Bool {
        UIApplication.shared.alternateIconName == "Legacy"
    }

    func performSelectedAction(_ sender: Any) {
        let iconName = isOn ? nil : "Legacy"
        UIApplication.shared.setAlternateIconName(iconName) { _ in
            if let tableView = (sender as? UITableView) {
                tableView.reloadData()
                if let selectedIndexPath = tableView.indexPathForSelectedRow {
                    tableView.deselectRow(at: selectedIndexPath, animated: true)
                }
            }
        }
    }
}
