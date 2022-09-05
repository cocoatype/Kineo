//  Created by Geoff Pado on 3/22/20.
//  Copyright © 2020 Cocoatype, LLC. All rights reserved.

import Foundation

class GalleryButton: SidebarActionButton {
    init() {
        super.init(icon: Icons.gallery, selector: #selector(SceneActions.showGallery))
        accessibilityLabel = NSLocalizedString("GalleryButton.accessibilityLabel", comment: "Accessibility label for the help button")
    }
}
