//  Created by Geoff Pado on 10/11/21.
//  Copyright © 2021 Cocoatype, LLC. All rights reserved.

import UIKit

class MenuButton: SidebarActionButton {
    init() {
        super.init(icon: Icons.menu, menu: Self.menu)
        accessibilityLabel = Self.accessibilityLabel
    }

    private static let menu = UIMenu(children: [
        UICommand(title: MenuButton.exportItemTitle, image: Icons.export, action: #selector(EditingViewController.exportVideo)),
        UIMenu(options: [.displayInline], children: [
            UICommand(title: MenuButton.backgroundColorItemTitle, image: Icons.colorBackground, action: #selector(EditingViewController.changeBackgroundColor)),
            UICommand(title: MenuButton.backgroundImageItemTitle, image: Icons.imageBackground, action: #selector(EditingViewController.changeBackgroundImage))
        ])
    ])

    private static let accessibilityLabel = NSLocalizedString("MenuButton.accessibilityLabel", comment: "Accessibility label for the compact menu button")
    private static let backgroundColorItemTitle = NSLocalizedString("MenuButton.backgroundColorItemTitle", comment: "Title for the menu button's background color item")
    private static let backgroundImageItemTitle = NSLocalizedString("MenuButton.backgroundImageItemTitle", comment: "Title for the menu button's background image item")
    private static let exportItemTitle = NSLocalizedString("MenuButton.exportItemTitle", comment: "Title for the menu button's export item")
}
