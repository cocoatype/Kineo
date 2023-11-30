//  Created by Geoff Pado on 3/1/20.
//  Copyright © 2020 Cocoatype, LLC. All rights reserved.

import UIKit

class FrameAnimation: CABasicAnimation {
    init(from: CGRect, to: CGRect) {
        super.init()
        keyPath = #keyPath(CALayer.frame)
        fromValue = from
        toValue = to
    }

    override init() { super.init() } // needed to not crash
    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}

class ContentsAnimation: CABasicAnimation {
    init(from: Any?, to: CGImage?) {
        super.init()
        keyPath = #keyPath(CALayer.contents)
        fromValue = from
        toValue = to
    }

    override init() { super.init() } // needed to not crash
    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
