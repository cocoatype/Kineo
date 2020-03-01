//  Created by Geoff Pado on 2/29/20.
//  Copyright © 2020 Cocoatype, LLC. All rights reserved.

import UIKit

class PresentationDirector: NSObject {
    func animatePresentation(from galleryViewController: GalleryViewController, to editingViewController: EditingViewController, in sceneViewController: SceneViewController) {
        sceneViewController.transition(to: editingViewController)
    }
}
