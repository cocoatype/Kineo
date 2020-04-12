//  Created by Geoff Pado on 2/8/20.
//  Copyright © 2020 Cocoatype, LLC. All rights reserved.

import UIKit

class ExportSettingsTableViewCell: UITableViewCell {
    static let identifier = "ExportSettingsTableViewCell.identifier"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        textLabel?.font = .appFont(forTextStyle: .body)
        tintColor = .settingsRowTint
    }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
