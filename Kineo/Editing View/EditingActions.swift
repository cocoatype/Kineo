//  Created by Geoff Pado on 11/16/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import UIKit

class GalleryButton: SidebarActionButton {
    init() {
        super.init(icon: Icons.gallery, selector: #selector(SceneViewController.showGallery))
    }
}

class ExportButton: SidebarActionButton {
    init() {
        super.init(icon: Icons.export, selector: #selector(EditingViewController.exportVideo))
    }
}

class PlayButton: SidebarActionButton {
    init() {
        super.init(icon: Icons.play, selector: #selector(EditingViewController.play))
    }
}

class ToolsButton: SidebarActionButton {
    init() {
        super.init(icon: Icons.tools, selector: #selector(EditingViewController.toggleToolPicker))
    }
}

class UndoButton: SidebarActionButton {
    init() {
        super.init(icon: Icons.undo, selector: #selector(UndoManager.undo))
    }
}

class RedoButton: SidebarActionButton {
    init() {
        super.init(icon: Icons.redo, selector: #selector(UndoManager.redo))
    }
}
