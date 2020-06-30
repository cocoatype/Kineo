//  Created by Geoff Pado on 11/10/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import UIKit

class GalleryDocumentCollectionViewCellBackgroundView: UIView {
    init() {
        super.init(frame: .zero)
        backgroundColor = .clear
        translatesAutoresizingMaskIntoConstraints = false

        layer.addSublayer(darkShadowLayer)
        layer.addSublayer(lightShadowLayer)

        addSubview(previewImageView)

        NSLayoutConstraint.activate([
            previewImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            previewImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            previewImageView.widthAnchor.constraint(equalTo: widthAnchor),
            previewImageView.heightAnchor.constraint(equalTo: heightAnchor)
        ])
    }

    var previewImage: UIImage? {
        get { return previewImageView.image }
        set(newImage) {
            previewImageView.image = newImage
        }
    }

    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        maskLayer.frame = layer.bounds
        maskLayer.path = currentPath.cgPath

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
        layer.shadowOffset = CGSize(width: 0, height: 6)
        layer.shadowOpacity = 1
        layer.shadowRadius = 8
        return layer
    }()

    private let lightShadowLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.rasterizationScale = UIScreen.main.scale
        layer.shouldRasterize = true
        layer.fillColor = UIColor.canvasBackground.cgColor
        layer.strokeColor = UIColor.canvasBorder.cgColor
        layer.shadowColor = UIColor.canvasShadowLight.cgColor
        layer.shadowOffset = CGSize(width: 0, height: -6)
        layer.shadowOpacity = 1
        layer.shadowRadius = 8
        return layer
    }()

    // MARK: Boilerplate

    private let maskLayer = CAShapeLayer()
    private let previewImageView = GalleryDocumentPreviewImageView()

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
