//  Created by Geoff Pado on 12/24/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import UIKit

public extension CGRect {
    static func / (lhs: CGRect, rhs: CGRect) -> CGFloat {
        return lhs.width / rhs.width
    }

    static func / (lhs: CGRect, rhs: CGSize) -> CGFloat {
        return lhs.width / rhs.width
    }

    var center: CGPoint {
        CGPoint(x: midX, y: midY)
    }

    init(center: CGPoint, size: CGSize) {
        let origin = center.applying(CGAffineTransform(translationX: -size.width/2, y: -size.height/2))
        self.init(origin: origin, size: size)
    }
}

public extension CGSize {
    static func / (lhs: CGSize, rhs: CGSize) -> CGFloat {
        return lhs.width / rhs.width
    }

    static func / (lhs: CGSize, rhs: CGRect) -> CGFloat {
        return lhs.width / rhs.width
    }
}

public extension CGPoint {
    static func * (lhs: CGPoint, rhs: CGFloat) -> CGPoint {
        return CGPoint(x: lhs.x * rhs, y: lhs.y * rhs)
    }
}
