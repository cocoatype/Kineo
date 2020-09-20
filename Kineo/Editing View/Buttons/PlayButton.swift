//  Created by Geoff Pado on 3/22/20.
//  Copyright © 2020 Cocoatype, LLC. All rights reserved.

import Data
import UIKit

class PlayButton: SidebarActionButton {
    init() {
        super.init(icon: Icons.play, selector: #selector(EditingViewController.play))
        accessibilityLabel = NSLocalizedString("PlayButton.accessibilityLabel", comment: "Accessibility label for the help button")
        updateAccessibilityActions()

        addTarget(nil, action: #selector(EditingViewController.playMultiple), for: .touchDownRepeat)
        addInteraction(PlayButtonContextMenuFactory.interaction(button: self))
    }

    override func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        guard UIAccessibility.isVoiceOverRunning == false else { return nil }
        return PlayButtonContextMenuFactory.configuration(button: self)
    }

    override var isSelected: Bool {
        didSet {
            updateAccessibilityActions()
            image = isSelected ? Icons.pause : Icons.play
        }
    }

    // MARK: Actions

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

    // MARK: Accessibility

    private func updateAccessibilityActions() {
        if isSelected {
            accessibilityCustomActions = []
        } else {
            accessibilityCustomActions = [
                UIAccessibilityCustomAction(name: PlayButtonContextMenuFactory.loopMenuItemTitle, target: self, selector: #selector(loop)),
                UIAccessibilityCustomAction(name: PlayButtonContextMenuFactory.bounceMenuItemTitle, target: self, selector: #selector(bounce))
            ]
        }
    }
}
