//  Created by Geoff Pado on 11/16/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import Foundation

public class HelpButton: SidebarActionButton {
    public init() {
        super.init(icon: Icons.help, selector: #selector(SceneActions.presentHelp))
        accessibilityLabel = NSLocalizedString("HelpButton.accessibilityLabel", comment: "Accessibility label for the help button")
    }
}
