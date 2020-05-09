//  Created by Geoff Pado on 3/22/20.
//  Copyright © 2020 Cocoatype, LLC. All rights reserved.

import Data
import UIKit

class PlayButton: SidebarActionButton, UIContextMenuInteractionDelegate {
    init() {
        super.init(icon: Icons.play, selector: #selector(EditingViewController.play))
        accessibilityCustomActions = [
            UIAccessibilityCustomAction(name: PlayButtonContextMenuFactory.loopMenuItemTitle, target: self, selector: #selector(loop)),
            UIAccessibilityCustomAction(name: PlayButtonContextMenuFactory.bounceMenuItemTitle, target: self, selector: #selector(bounce))
        ]
        accessibilityLabel = NSLocalizedString("PlayButton.accessibilityLabel", comment: "Accessibility label for the help button")

        addTarget(nil, action: #selector(EditingViewController.playMultiple), for: .touchDownRepeat)
        addInteraction(PlayButtonContextMenuFactory.interaction(button: self))
    }

    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        PlayButtonContextMenuFactory.configuration(button: self)
    }

    // these two methods return bools because it is required by UIAccessibilityCustomAction
    @objc @discardableResult func loop() -> Bool {
        Defaults.exportPlaybackStyle = .loop
        sendActions(for: .touchDownRepeat)
        return true
    }

    @objc @discardableResult func bounce() -> Bool {
        Defaults.exportPlaybackStyle = .bounce
        sendActions(for: .touchDownRepeat)
        return true
    }
}
