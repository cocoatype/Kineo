//  Created by Geoff Pado on 6/15/20.
//  Copyright © 2020 Cocoatype, LLC. All rights reserved.

import UIKit

class SidebarActionButtonBackgroundView: UIView {
    init() {
        super.init(frame: .zero)
        isUserInteractionEnabled = false
        translatesAutoresizingMaskIntoConstraints = false

        layer.addSublayer(darkShadowLayer)
        layer.addSublayer(lightShadowLayer)
        layer.addSublayer(fillLayer)
    }

    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        darkShadowLayer.frame = layer.bounds
        lightShadowLayer.frame = darkShadowLayer.frame
        fillLayer.frame = darkShadowLayer.frame
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        guard traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) else { return }
        darkShadowLayer.traitCollection = traitCollection
        lightShadowLayer.traitCollection = traitCollection
        fillLayer.traitCollection = traitCollection
    }

    // MARK: Shadow Layers

    private let darkShadowLayer = SidebarActionButtonBackgroundDarkShadowLayer()
    private let lightShadowLayer = SidebarActionButtonBackgroundLightShadowLayer()
    private let fillLayer = SidebarActionButtonBackgroundFillLayer()

    // MARK: Highlighting/Selecting

    var isHighlighted = false {
        didSet {
            fillLayer.isHighlighted = isHighlighted
        }
    }

    var isSelected = false {
        didSet {
            fillLayer.isSelected = isSelected
        }
    }

    // MARK: Boilerplate

    static let cornerRadius = CGFloat(8)

    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) is not implemented")
    }
}
