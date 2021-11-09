//  Created by Geoff Pado on 10/11/21.
//  Copyright © 2021 Cocoatype, LLC. All rights reserved.

import UIKit

class SidebarActionContextMenuInteraction: UIContextMenuInteraction {
    init(menu: UIMenu) {
        let delegate = Delegate(menu: menu)
        self.menuDelegate = delegate
        super.init(delegate: delegate)
    }

    class Delegate: NSObject, UIContextMenuInteractionDelegate {
        init(menu: UIMenu) {
            self.menu = menu
        }

        func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
            UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { [weak self] _ in
                return self?.menu
            }
        }

        private let menu: UIMenu
    }

    private let menuDelegate: Delegate
}
