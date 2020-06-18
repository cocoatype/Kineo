//  Created by Geoff Pado on 6/15/20.
//  Copyright © 2020 Cocoatype, LLC. All rights reserved.

import UIKit

class FilmStripForegroundView: UIView {
    init() {
        super.init(frame: .zero)
        layer.addSublayer(darkShadowLayer)
        layer.addSublayer(lightShadowLayer)
        backgroundColor = UIColor.clear
        isUserInteractionEnabled = false
        translatesAutoresizingMaskIntoConstraints = false
    }

    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        darkShadowLayer.frame = layer.bounds
        darkShadowLayer.containerBounds = darkShadowLayer.bounds
        lightShadowLayer.frame = darkShadowLayer.frame
        lightShadowLayer.containerBounds = darkShadowLayer.containerBounds
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        guard traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) else { return }
        darkShadowLayer.shadowColor = UIColor.filmStripShadowDark.cgColor
        lightShadowLayer.shadowColor = UIColor.filmStripShadowLight.cgColor
    }

    private let darkShadowLayer: InnerShadowLayer = {
        let layer = InnerShadowLayer()
        layer.shadowColor = UIColor.filmStripShadowDark.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 3)
        return layer
    }()

    private let lightShadowLayer: InnerShadowLayer = {
        let layer = InnerShadowLayer()
        layer.shadowColor = UIColor.filmStripShadowLight.cgColor
        layer.shadowOffset = CGSize(width: 0, height: -3)
        return layer
    }()

    // MARK: Boilerplate

    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) is not implemented")
    }
}

class InnerShadowLayer: CAShapeLayer {
    override init() {
        super.init()
        cornerRadius = 10
        fillColor = UIColor.clear.cgColor
        masksToBounds = true
        shadowOpacity = 1
        shadowRadius = 4
        strokeColor = UIColor.filmStripBorder.cgColor
    }

    var containerBounds = CGRect.zero {
        didSet {
            let outset = shadowRadius * -0.5
            let outsetBounds = containerBounds.insetBy(dx: outset, dy: outset)
            let outsetBoundsStrokePath = UIBezierPath(roundedRect: outsetBounds, cornerRadius: cornerRadius).cgPath // TODO: Figure out the math here
            path = outsetBoundsStrokePath.copy(strokingWithWidth: shadowRadius, lineCap: .butt, lineJoin: .miter, miterLimit: miterLimit)
            shadowPath = path
        }
    }

    // MARK: Boilerplate

    override init(layer: Any) {
        super.init(layer: layer)
    }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) is not implemented")
    }
}
