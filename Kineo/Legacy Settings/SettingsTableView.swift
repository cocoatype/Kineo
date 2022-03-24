//  Created by Geoff Pado on 4/27/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import UIKit

class SettingsTableView: UITableView {
    init() {
        super.init(frame: .zero, style: .insetGrouped)
        backgroundColor = .appBackground

        register(SettingsStandardTableViewCell.self, forCellReuseIdentifier: SettingsStandardTableViewCell.identifier)
    }

    // MARK: Boilerplate

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let className = String(describing: type(of: self))
        fatalError("\(className) does not implement init(coder:)")
    }
}
