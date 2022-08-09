//  Created by Geoff Pado on 3/22/20.
//  Copyright © 2020 Cocoatype, LLC. All rights reserved.

import Foundation

class ExportButton: SidebarActionButton {
    init() {
        super.init(icon: Icons.export, selector: #selector(EditingDrawViewController.exportVideo))
        accessibilityLabel = NSLocalizedString("ExportButton.accessibilityLabel", comment: "Accessibility label for the help button")
    }
}
