//  Created by Geoff Pado on 8/8/22.
//  Copyright © 2022 Cocoatype, LLC. All rights reserved.

import UIKit

class DisplayModeButton: SidebarActionButton {
    init(mode: DisplayMode = .draw) {
        super.init(icon: mode.icon)
        accessibilityLabel = NSLocalizedString("DisplayModeButton.accessibilityLabel", comment: "Accessiblity label for the display mode button")
    }

    private static let menu = UIMenu(children: [
        UICommand(title: DisplayModeButton.drawItemTitle, image: Icons.DisplayMode.draw, action: #selector(EditingViewController.setDrawDisplayMode), state: .on),
        UICommand(title: DisplayModeButton.playItemTitle, image: Icons.DisplayMode.play, action: #selector(EditingViewController.setPlayDisplayMode)),
        UICommand(title: DisplayModeButton.framesItemTitle, image: Icons.DisplayMode.frames, action: #selector(EditingViewController.setFramesDisplayMode)),
        UICommand(title: DisplayModeButton.compareItemTitle, image: Icons.DisplayMode.compare, action: #selector(EditingViewController.setCompareDisplayMode))
    ])
    override var menu: UIMenu { Self.menu }

    private static let menuTitle = NSLocalizedString("DisplayModeButton.menuTitle", comment: "Title for the background button's menu")
    private static let compareItemTitle = NSLocalizedString("DisplayModeButton.compareItemTitle", comment: "Title for the display mode button's compare item")
    private static let drawItemTitle = NSLocalizedString("DisplayModeButton.drawItemTitle", comment: "Title for the display mode button's draw item")
    private static let framesItemTitle = NSLocalizedString("DisplayModeButton.framesItemTitle", comment: "Title for the display mode button's frames item")
    private static let playItemTitle = NSLocalizedString("DisplayModeButton.playItemTitle", comment: "Title for the display mode button's play item")

}

private extension DisplayMode {
    var icon: UIImage? {
        switch self {
        case .draw: return Icons.DisplayMode.draw
        case .play: return Icons.DisplayMode.play
        case .frames: return Icons.DisplayMode.frames
        case .compare: return Icons.DisplayMode.compare
        }
    }
}
