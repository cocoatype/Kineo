//  Created by Geoff Pado on 4/27/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import UIKit

protocol SettingsContentTableViewCell: UITableViewCell {
    var item: SettingsContentItem? { get set }
}

class SettingsStandardTableViewCell: UITableViewCell, SettingsContentTableViewCell {
    static let identifier = "SettingsTableViewCell.identifier"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: SettingsStandardTableViewCell.identifier)
        accessoryType = .disclosureIndicator
        tintColor = .settingsRowTint

        let selectedBackgroundView = UIView()
        selectedBackgroundView.backgroundColor = .sidebarButtonHighlight
        self.selectedBackgroundView = selectedBackgroundView
    }

    var item: SettingsContentItem? {
        didSet {
            textLabel?.text = item?.title
            detailTextLabel?.text = item?.subtitle

            imageView?.image = (item as? IconProvidingContentItem)?.icon
            imageView?.layer.cornerRadius = 6
            imageView?.clipsToBounds = true

            if let switchableItem = (item as? SwitchableContentItem) {
                let itemSwitch = UISwitch()
                itemSwitch.isOn = switchableItem.isOn
                itemSwitch.addTarget(self, action: #selector(handleAccessoryAction(_:)), for: .valueChanged)
                accessoryView = itemSwitch
            } else { accessoryView = nil }
        }
    }

    @objc private func handleAccessoryAction(_ sender: Any) {
        guard let accessoryView = sender as? UIView, accessoryView == self.accessoryView, let tableView = self.tableView else { return }
        item?.performSelectedAction(tableView)
    }

    // MARK: Boilerplate

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let className = String(describing: type(of: self))
        fatalError("\(className) does not implement init(coder:)")
    }
}

private extension UIResponder {
    var tableView: UITableView? {
        guard let tableView = self as? UITableView else { return next?.tableView }
        return tableView
    }
}
