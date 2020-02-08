//  Created by Geoff Pado on 2/7/20.
//  Copyright © 2020 Cocoatype, LLC. All rights reserved.

import CoreGraphics

enum ExportSettings {
    case standard
    case loop(minimumDuration: CGFloat)
    case bounce(minimumDuration: CGFloat)
}
