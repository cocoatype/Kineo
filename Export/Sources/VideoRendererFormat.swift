//  Created by Geoff Pado on 5/23/22.
//  Copyright © 2022 Cocoatype, LLC. All rights reserved.

import UIKit

public class VideoRendererFormat: UIGraphicsImageRendererFormat {
    public override init() {
        super.init()
        opaque = true
        scale = 1
    }
}
