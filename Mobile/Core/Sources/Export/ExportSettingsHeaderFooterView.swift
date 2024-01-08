//  Created by Geoff Pado on 3/16/20.
//  Copyright © 2020 Cocoatype, LLC. All rights reserved.

import UIKit

class ExportSettingsHeaderFooterView: UITableViewHeaderFooterView {
    static let identifier = "ExportSettingsHeaderFooterView.identifier"

    override func layoutSubviews() {
        super.layoutSubviews()
        textLabel?.font = .appFont(forTextStyle: .footnote)
    }
}
