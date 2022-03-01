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
    }

    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        darkShadowLayer.frame = layer.bounds
        darkShadowLayer.path = UIBezierPath(roundedRect: darkShadowLayer.bounds, cornerRadius: Self.cornerRadius).cgPath
        darkShadowLayer.shadowPath = darkShadowLayer.path
        lightShadowLayer.frame = darkShadowLayer.frame
        lightShadowLayer.path = darkShadowLayer.path
        lightShadowLayer.shadowPath = darkShadowLayer.shadowPath
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        guard traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) else { return }
        darkShadowLayer.fillColor = buttonBackgroundColor.cgColor
        darkShadowLayer.shadowColor = UIColor.sidebarButtonShadowDark.cgColor
        darkShadowLayer.strokeColor = UIColor.sidebarButtonBorder.cgColor
        lightShadowLayer.fillColor = buttonBackgroundColor.cgColor
        lightShadowLayer.shadowColor = UIColor.sidebarButtonShadowLight.cgColor
        lightShadowLayer.strokeColor = UIColor.sidebarButtonBorder.cgColor
    }

    // MARK: Shadow Layers

    private let darkShadowLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.fillColor = UIColor.sidebarButtonBackground.cgColor
        layer.strokeColor = UIColor.sidebarButtonBorder.cgColor
        layer.shadowColor = UIColor.sidebarButtonShadowDark.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 3)
        layer.shadowOpacity = 1
        layer.shadowRadius = 8
        return layer
    }()

    private let lightShadowLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.fillColor = UIColor.sidebarButtonBackground.cgColor
        layer.strokeColor = UIColor.sidebarButtonBorder.cgColor
        layer.shadowColor = UIColor.sidebarButtonShadowLight.cgColor
        layer.shadowOffset = CGSize(width: 0, height: -3)
        layer.shadowOpacity = 1
        layer.shadowRadius = 8
        return layer
    }()

    // MARK: Highlighting/Selecting

    var isHighlighted = false {
        didSet {
            darkShadowLayer.fillColor = buttonBackgroundColor.cgColor
            lightShadowLayer.fillColor = buttonBackgroundColor.cgColor
        }
    }

    var isSelected = false {
        didSet {
            darkShadowLayer.fillColor = buttonBackgroundColor.cgColor
            lightShadowLayer.fillColor = buttonBackgroundColor.cgColor
        }
    }

    private var buttonBackgroundColor: UIColor {
        if isHighlighted { return .sidebarButtonHighlight }
        else if isSelected { return .sidebarButtonBackgroundSelected }
        return .sidebarButtonBackground
    }

    // MARK: Boilerplate

    private static let cornerRadius = CGFloat(8)

    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) is not implemented")
    }
}
