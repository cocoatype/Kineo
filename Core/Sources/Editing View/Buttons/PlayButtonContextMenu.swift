//  Created by Geoff Pado on 3/2/20.
//  Copyright © 2020 Cocoatype, LLC. All rights reserved.

import UIKit

enum PlayButtonContextMenuFactory {
    static func interaction(button: PlayButton) -> UIContextMenuInteraction {
        UIContextMenuInteraction(delegate: button)
    }

    static func configuration(button: PlayButton) -> UIContextMenuConfiguration {
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil, actionProvider: actionProvider(for: button))
    }

    private static func actionProvider(for button: PlayButton) -> UIContextMenuActionProvider {
        return { _ in
            let loopElement = UIAction(title: Self.loopMenuItemTitle, image: Icons.ContextMenu.loop) { _ in button.loop() }
            let bounceElement = UIAction(title: Self.bounceMenuItemTitle, image: Icons.ContextMenu.bounce) { _ in button.bounce() }

            return UIMenu(title: "", children: [loopElement, bounceElement])
        }
    }

    static let loopMenuItemTitle = NSLocalizedString("PlayButtonContextMenuConfigurationFactory.loopMenuItemTitle", comment: "Menu item title for playing a standard loop")
    static let bounceMenuItemTitle = NSLocalizedString("PlayButtonContextMenuConfigurationFactory.bounceMenuItemTitle", comment: "Menu item title for playing a bouncing loop")
}
