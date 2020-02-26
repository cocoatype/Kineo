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
        }
    }

    // MARK: Boilerplate

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let className = String(describing: type(of: self))
        fatalError("\(className) does not implement init(coder:)")
    }
}
