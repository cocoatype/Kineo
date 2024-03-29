//  Created by Geoff Pado on 6/15/20.
//  Copyright © 2020 Cocoatype, LLC. All rights reserved.

#if os(iOS) && !os(visionOS)
import DataPhone
import StylePhone
#elseif os(visionOS)
import DataVision
import StyleVision
#endif

import UIKit

public class DrawingBackgroundView: UIView {
    public init() {
        super.init(frame: .zero)
        isUserInteractionEnabled = false
        translatesAutoresizingMaskIntoConstraints = false

        layer.addSublayer(darkShadowLayer)
        layer.addSublayer(lightShadowLayer)
    }

    public override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        darkShadowLayer.frame = layer.bounds
        darkShadowLayer.shadowPath = UIBezierPath(roundedRect: darkShadowLayer.bounds, cornerRadius: Self.cornerRadius).cgPath
        lightShadowLayer.frame = darkShadowLayer.frame
        lightShadowLayer.shadowPath = darkShadowLayer.shadowPath
    }

    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        guard traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) else { return }
        darkShadowLayer.shadowColor = Asset.canvasShadowDark.color.cgColor
        lightShadowLayer.shadowColor = Asset.canvasShadowLight.color.cgColor
    }

    // MARK: Shadow Layers

    private let darkShadowLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.fillColor = UIColor.clear.cgColor
        layer.shadowColor = Asset.canvasShadowDark.color.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 12)
        layer.shadowOpacity = 1
        layer.shadowRadius = 32
        return layer
    }()

    private let lightShadowLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.fillColor = UIColor.clear.cgColor
        layer.shadowColor = Asset.canvasShadowLight.color.cgColor
        layer.shadowOffset = CGSize(width: 0, height: -12)
        layer.shadowOpacity = 1
        layer.shadowRadius = 32
        return layer
    }()

    // MARK: Boilerplate

    private static let cornerRadius = Constants.canvasCornerRadius

    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) is not implemented")
    }
}
