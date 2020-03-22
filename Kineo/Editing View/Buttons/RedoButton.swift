//  Created by Geoff Pado on 3/22/20.
//  Copyright © 2020 Cocoatype, LLC. All rights reserved.

import Foundation

class RedoButton: SidebarActionButton {
    init() {
        super.init(icon: Icons.redo, selector: #selector(EditingViewController.redoDrawing))
        accessibilityLabel = NSLocalizedString("RedoButton.accessibilityLabel", comment: "Accessibility label for the help button")
    }
}
