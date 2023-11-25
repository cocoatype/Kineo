//  Created by Geoff Pado on 12/24/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import UIKit

public extension CGRect {
    static func * (rect: CGRect, multiplier: CGFloat) -> CGRect {
        return CGRect(x: rect.origin.x * multiplier, y: rect.origin.y * multiplier, width: rect.size.width * multiplier, height: rect.size.height * multiplier)
    }

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

    func fitting(rect fittingRect: CGRect) -> CGRect {
        let aspectRatio = width / height
        let fittingAspectRatio = fittingRect.width / fittingRect.height

        if fittingAspectRatio > aspectRatio { //wider fitting rect
            let newRectWidth = aspectRatio * fittingRect.height
            let newRectHeight = fittingRect.height
            let newRectX = (fittingRect.width - newRectWidth) / 2
            let newRectY = CGFloat(0)

            return CGRect(x: newRectX, y: newRectY, width: newRectWidth, height: newRectHeight)
        } else if fittingAspectRatio < aspectRatio { //taller fitting rect
            let newRectWidth = fittingRect.width
            let newRectHeight = 1 / (aspectRatio / fittingRect.width)
            let newRectX = CGFloat(0)
            let newRectY = (fittingRect.height - newRectHeight) / 2

            return CGRect(x: newRectX, y: newRectY, width: newRectWidth, height: newRectHeight)
        } else { //same aspect ratio
            return fittingRect
        }
    }

    func filling(rect fillingRect: CGRect) -> CGRect {
        let aspectRatio = width / height
        let fillingAspectRatio = fillingRect.width / fillingRect.height

        if fillingAspectRatio > aspectRatio { //wider fitting rect
            let newRectWidth = fillingRect.width
            let newRectHeight = 1 / (aspectRatio / fillingRect.width)
            let newRectX = CGFloat(0)
            let newRectY = (fillingRect.height - newRectHeight) / 2

            return CGRect(x: newRectX, y: newRectY, width: newRectWidth, height: newRectHeight)
        } else if fillingAspectRatio < aspectRatio { //taller fitting rect
            let newRectWidth = aspectRatio * fillingRect.height
            let newRectHeight = fillingRect.height
            let newRectX = (fillingRect.width - newRectWidth) / 2
            let newRectY = CGFloat(0)

            return CGRect(x: newRectX, y: newRectY, width: newRectWidth, height: newRectHeight)
        } else { // same aspect ratio
            return fillingRect
        }
    }
}

public extension CGSize {
    static func / (lhs: CGSize, rhs: CGSize) -> CGFloat {
        return lhs.width / rhs.width
    }

    static func / (lhs: CGSize, rhs: CGRect) -> CGFloat {
        return lhs.width / rhs.width
    }

    static func * (size: CGSize, multiplier: CGFloat) -> CGSize {
        return CGSize(width: size.width * multiplier, height: size.height * multiplier)
    }
}

public extension CGPoint {
    static func * (lhs: CGPoint, rhs: CGFloat) -> CGPoint {
        return CGPoint(x: lhs.x * rhs, y: lhs.y * rhs)
    }
}
