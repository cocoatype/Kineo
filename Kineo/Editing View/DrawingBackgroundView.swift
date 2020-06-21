//  Created by Geoff Pado on 6/15/20.
//  Copyright © 2020 Cocoatype, LLC. All rights reserved.

import UIKit

class DrawingBackgroundView: UIView {
    init() {
        super.init(frame: .zero)
        isUserInteractionEnabled = false
        translatesAutoresizingMaskIntoConstraints = false

        layer.addSublayer(darkShadowLayer)
        layer.addSublayer(lightShadowLayer)
    }

    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        darkShadowLayer.frame = layer.bounds
        darkShadowLayer.shadowPath = UIBezierPath(roundedRect: darkShadowLayer.bounds, cornerRadius: Self.cornerRadius).cgPath
        lightShadowLayer.frame = darkShadowLayer.frame
        lightShadowLayer.shadowPath = darkShadowLayer.shadowPath
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        guard traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) else { return }
        darkShadowLayer.shadowColor = UIColor.canvasShadowDark.cgColor
        lightShadowLayer.shadowColor = UIColor.canvasShadowLight.cgColor
    }

    // MARK: Shadow Layers

    private let darkShadowLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.fillColor = UIColor.clear.cgColor
        layer.shadowColor = UIColor.canvasShadowDark.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 12)
        layer.shadowOpacity = 1
        layer.shadowRadius = 32
        return layer
    }()

    private let lightShadowLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.fillColor = UIColor.clear.cgColor
        layer.shadowColor = UIColor.canvasShadowLight.cgColor
        layer.shadowOffset = CGSize(width: 0, height: -12)
        layer.shadowOpacity = 1
        layer.shadowRadius = 32
        return layer
    }()

    // MARK: Boilerplate

    private static let cornerRadius = CGFloat(8)

    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) is not implemented")
    }
}
