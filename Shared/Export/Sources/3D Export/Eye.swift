//  Created by Geoff Pado on 9/29/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import CoreMedia

@available(iOS 17.0, *)
enum Eye {
    case left
    case right

    var videoLayerID: Int {
        switch self {
        case .left: return 0
        case .right: return 1
        }
    }

    var stereoView: CMStereoViewComponents {
        switch self {
        case .left: return .leftEye
        case .right: return .rightEye
        }
    }

    var offset: CGFloat {
        switch self {
        case .left: return -1.0
        case .right: return 1.0
        }
    }
}
