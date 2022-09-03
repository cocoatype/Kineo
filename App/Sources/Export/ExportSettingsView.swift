//  Created by Geoff Pado on 2/8/20.
//  Copyright © 2020 Cocoatype, LLC. All rights reserved.

import UIKit

class ExportSettingsView: UITableView {
    init() {
        super.init(frame: .zero, style: .insetGrouped)
        register(ExportSettingsTableViewCell.self, forCellReuseIdentifier: ExportSettingsTableViewCell.identifier)
        backgroundColor = .appBackground
    }

    // MARK: Boilerplate

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
