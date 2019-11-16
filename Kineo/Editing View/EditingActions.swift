//  Created by Geoff Pado on 11/16/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import UIKit

struct GalleryNavigationAction: SidebarAction {
    var icon: UIImage? { return Icons.gallery }
    var selector: Selector { return #selector(SceneViewController.showGallery) }
    var target: Any? { return nil }
}
