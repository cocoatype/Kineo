//  Created by Geoff Pado on 3/22/20.
//  Copyright © 2020 Cocoatype, LLC. All rights reserved.

import Foundation

class UndoButton: SidebarActionButton {
    init() {
        super.init(icon: Icons.undo, selector: #selector(EditingViewController.undoDrawing))
        accessibilityLabel = NSLocalizedString("UndoButton.accessibilityLabel", comment: "Accessibility label for the help button")
    }
}
