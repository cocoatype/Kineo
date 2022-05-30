//  Created by Geoff Pado on 10/11/21.
//  Copyright © 2021 Cocoatype, LLC. All rights reserved.

import Data
import UIKit

class MenuButton: SidebarActionButton {
    init() {
        super.init(icon: Icons.menu)
        accessibilityLabel = Self.accessibilityLabel
    }

    override var menu: UIMenu {
        UIMenu(children: [
            UICommand(title: MenuButton.exportItemTitle, image: Icons.export, action: #selector(EditingViewController.exportVideo)),
            backgroundSubmenu
        ])
    }

    private var backgroundSubmenu: UIMenu {
        var childItems = [UICommand(title: MenuButton.backgroundColorItemTitle, image: Icons.colorBackground, action: #selector(EditingViewController.changeBackgroundColor))]

        if (Defaults.hideBackgroundImagePurchaseAlert == false || AppPurchaseStateObserver.shared.isPurchased == true), #available(iOS 15, *) {
            childItems.append(UICommand(title: MenuButton.backgroundImageItemTitle, image: Icons.imageBackground, action: #selector(EditingViewController.changeBackgroundImage)))
        }

        return UIMenu(options: [.displayInline], children: childItems)
    }

    private static let accessibilityLabel = NSLocalizedString("MenuButton.accessibilityLabel", comment: "Accessibility label for the compact menu button")
    private static let backgroundColorItemTitle = NSLocalizedString("MenuButton.backgroundColorItemTitle", comment: "Title for the menu button's background color item")
    private static let backgroundImageItemTitle = NSLocalizedString("MenuButton.backgroundImageItemTitle", comment: "Title for the menu button's background image item")
    private static let exportItemTitle = NSLocalizedString("MenuButton.exportItemTitle", comment: "Title for the menu button's export item")
}
