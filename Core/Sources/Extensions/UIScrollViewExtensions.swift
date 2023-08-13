//  Created by Geoff Pado on 2/27/21.
//  Copyright © 2021 Cocoatype, LLC. All rights reserved.

import UIKit

extension UIScrollView {
    var isScrollUserInitiated: Bool {
        return isTracking || isDragging || isDecelerating
    }
}
