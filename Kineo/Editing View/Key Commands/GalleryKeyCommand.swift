//  Created by Geoff Pado on 9/4/21.
//  Copyright © 2021 Cocoatype, LLC. All rights reserved.

import UIKit

class GalleryKeyCommand: EditingKeyCommand {
    init() {
        super.init(title: NSLocalizedString("EditingViewController.galleryKeyCommandTitle", comment: "Key command title for returning to the gallery"),
                   action: #selector(SceneViewController.showGallery),
                   input: "W",
                   modifierFlags: .command)
    }
}
