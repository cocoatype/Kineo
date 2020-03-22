//  Created by Geoff Pado on 3/22/20.
//  Copyright © 2020 Cocoatype, LLC. All rights reserved.

import Data
import UIKit

class PlayButton: SidebarActionButton, UIContextMenuInteractionDelegate {
    init() {
        super.init(icon: Icons.play, selector: #selector(EditingViewController.play))
        accessibilityLabel = NSLocalizedString("PlayButton.accessibilityLabel", comment: "Accessibility label for the help button")

        addTarget(nil, action: #selector(EditingViewController.playMultiple), for: .touchDownRepeat)
        addInteraction(PlayButtonContextMenuFactory.interaction(button: self))
    }

    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        PlayButtonContextMenuFactory.configuration(button: self)
    }

    func loop() {
        Defaults.exportPlaybackStyle = .loop
        sendActions(for: .touchDownRepeat)
    }

    func bounce() {
        Defaults.exportPlaybackStyle = .bounce
        sendActions(for: .touchDownRepeat)
    }
}
