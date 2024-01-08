//  Created by Geoff Pado on 4/19/22.
//  Copyright © 2022 Cocoatype, LLC. All rights reserved.

import StylePhone
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
                Asset.sidebarButtonPressedGradientDark.color(compatibleWith: traitCollection).cgColor,
                Asset.sidebarButtonPressedGradientLight.color(compatibleWith: traitCollection).cgColor,
            ]
        } else {
            colors = [
                Asset.sidebarButtonBackground.color(compatibleWith: traitCollection).cgColor
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
