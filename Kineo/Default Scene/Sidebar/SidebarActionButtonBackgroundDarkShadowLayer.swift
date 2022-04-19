//  Created by Geoff Pado on 4/19/22.
//  Copyright © 2022 Cocoatype, LLC. All rights reserved.

import UIKit

class SidebarActionButtonBackgroundDarkShadowLayer: CAShapeLayer {
    override init() {
        super.init()
        fillColor = UIColor.sidebarButtonBackground.cgColor
        strokeColor = UIColor.sidebarButtonBorder.cgColor
        shadowColor = UIColor.sidebarButtonShadowDark.cgColor
        shadowOffset = CGSize(width: 0, height: 5)
        shadowOpacity = 1
        shadowRadius = SidebarActionButtonBackgroundView.cornerRadius
    }

    override var frame: CGRect {
        didSet {
            path = UIBezierPath(
                roundedRect: bounds,
                cornerRadius: SidebarActionButtonBackgroundView.cornerRadius
            ).cgPath
            shadowPath = path
        }
    }

    var traitCollection = UITraitCollection.current {
        didSet {
            fillColor = UIColor.sidebarButtonBackground.resolvedColor(with: traitCollection).cgColor
            strokeColor = UIColor.sidebarButtonBorder.resolvedColor(with: traitCollection).cgColor
            shadowColor = UIColor.sidebarButtonShadowDark.resolvedColor(with: traitCollection).cgColor
        }
    }

    override init(layer: Any) {
        super.init(layer: layer)
    }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
