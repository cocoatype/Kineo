//  Created by Geoff Pado on 11/16/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import UIKit

class GalleryNavigationActionButton: SidebarActionButton {
    init() {
        super.init(icon: Icons.gallery, selector: #selector(SceneViewController.showGallery))
    }
}

class ExportActionButton: SidebarActionButton {
    init() {
        super.init(icon: Icons.export, selector: #selector(EditingViewController.exportVideo))
    }
}

class PlayActionButton: SidebarActionButton {
    init() {
        super.init(icon: Icons.play, selector: #selector(EditingViewController.play))
    }
}
