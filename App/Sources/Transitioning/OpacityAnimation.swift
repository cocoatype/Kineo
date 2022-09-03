//  Created by Geoff Pado on 3/1/20.
//  Copyright © 2020 Cocoatype, LLC. All rights reserved.

import UIKit

class OpacityAnimation: CABasicAnimation {
    init(from: CGFloat, to: CGFloat) {
        super.init()
        keyPath = #keyPath(CALayer.opacity)
        fromValue = min(max(from, 0), 1)
        toValue = min(max(to, 0), 1)
    }

    override init() { super.init() } // needed to not crash
    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
