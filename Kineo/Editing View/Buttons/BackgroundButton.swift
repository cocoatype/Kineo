//  Created by Geoff Pado on 3/18/22.
//  Copyright © 2022 Cocoatype, LLC. All rights reserved.

import UIKit

class BackgroundButton: SidebarActionButton {
    init() {
        super.init(icon: Icons.background, menu: Self.menu)
        accessibilityLabel = NSLocalizedString("BackgroundButton.accessibilityLabel", comment: "Accessibility label for the background color button")
    }

    private static let menu = UIMenu(title: BackgroundButton.menuTitle, children: [
        UICommand(title: BackgroundButton.colorItemTitle, image: Icons.colorBackground, action: #selector(EditingViewController.exportVideo)),
        UICommand(title: BackgroundButton.imageItemTitle, image: Icons.imageBackground, action: #selector(EditingViewController.changeBackgroundColor))
    ])

    private static let menuTitle = NSLocalizedString("BackgroundButton.menuTitle", comment: "Title for the background button's menu")
    private static let colorItemTitle = NSLocalizedString("BackgroundButton.colorItemTitle", comment: "Title for the background button's color item")
    private static let imageItemTitle = NSLocalizedString("BackgroundButton.imageItemTitle", comment: "Title for the background button's image item")
}
