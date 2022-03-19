//  Created by Geoff Pado on 3/18/22.
//  Copyright © 2022 Cocoatype, LLC. All rights reserved.

import Foundation

class BackgroundButton: SidebarActionButton {
    init() {
        super.init(icon: Icons.background, selector: #selector(EditingViewController.changeBackgroundColor(_:)))
        accessibilityLabel = NSLocalizedString("BackgroundButton.accessibilityLabel", comment: "Accessibility label for the background color button")
    }
}
