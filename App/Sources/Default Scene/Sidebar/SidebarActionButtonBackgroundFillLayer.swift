//  Created by Geoff Pado on 4/19/22.
//  Copyright © 2022 Cocoatype, LLC. All rights reserved.

import UIKit

class SidebarActionButtonBackgroundFillLayer: CAGradientLayer {
    override init() {
        super.init()
        cornerRadius = SidebarActionButtonBackgroundView.cornerRadius
        updateColors()
    }

    var traitCollection = UITraitCollection.current {
        didSet {
            updateColors()
        }
    }

    var isHighlighted = false {
        didSet {
            updateColors()
        }
    }

    var isSelected = false {
        didSet {
            updateColors()
        }
    }

    func updateColors() {
        if isHighlighted || isSelected {
            colors = [
                UIColor.sidebarButtonPressedGradientDark.resolvedColor(with: traitCollection).cgColor,
                UIColor.sidebarButtonPressedGradientLight.resolvedColor(with: traitCollection).cgColor,
            ]
        } else {
            colors = [
                UIColor.sidebarButtonBackground.resolvedColor(with: traitCollection).cgColor
            ]
        }
    }

    override init(layer: Any) {
        super.init(layer: layer)
    }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(Swift.type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
