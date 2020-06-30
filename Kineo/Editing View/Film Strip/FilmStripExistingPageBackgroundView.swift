//  Created by Geoff Pado on 6/30/20.
//  Copyright © 2020 Cocoatype, LLC. All rights reserved.

import UIKit

class FilmStripExistingPageBackgroundView: UIView {
    init() {
        super.init(frame: .zero)
        backgroundColor = .clear
        translatesAutoresizingMaskIntoConstraints = false

        layer.addSublayer(darkShadowLayer)
        layer.addSublayer(lightShadowLayer)
    }

    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)

        darkShadowLayer.frame = layer.bounds
        darkShadowLayer.path = currentPath.cgPath
        darkShadowLayer.shadowPath = darkShadowLayer.path
        lightShadowLayer.frame = darkShadowLayer.frame
        lightShadowLayer.path = darkShadowLayer.path
        lightShadowLayer.shadowPath = darkShadowLayer.shadowPath
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        guard traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) else { return }
        darkShadowLayer.shadowColor = UIColor.canvasShadowDark.cgColor
        lightShadowLayer.shadowColor = UIColor.canvasShadowLight.cgColor
    }

    private var currentPath: UIBezierPath {
        return UIBezierPath(roundedRect: bounds, cornerRadius: 8.0)
    }

    // MARK: Shadow Layers

    private let darkShadowLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.rasterizationScale = UIScreen.main.scale
        layer.shouldRasterize = true
        layer.fillColor = UIColor.canvasBackground.cgColor
        layer.strokeColor = UIColor.canvasBorder.cgColor
        layer.shadowColor = UIColor.canvasShadowDark.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 1)
        layer.shadowOpacity = 1
        layer.shadowRadius = 2
        return layer
    }()

    private let lightShadowLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.rasterizationScale = UIScreen.main.scale
        layer.shouldRasterize = true
        layer.fillColor = UIColor.canvasBackground.cgColor
        layer.strokeColor = UIColor.canvasBorder.cgColor
        layer.shadowColor = UIColor.canvasShadowLight.cgColor
        layer.shadowOffset = CGSize(width: 0, height: -1)
        layer.shadowOpacity = 1
        layer.shadowRadius = 2
        return layer
    }()

    // MARK: Boilerplate

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
