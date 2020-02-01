//  Created by Geoff Pado on 11/10/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import UIKit

class GalleryDocumentCollectionViewCellBackgroundView: UIView {
    init() {
        super.init(frame: .zero)
        backgroundColor = .canvasBackground
        translatesAutoresizingMaskIntoConstraints = false
        layer.mask = maskLayer

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
    }

    private var currentPath: UIBezierPath {
        return UIBezierPath(roundedRect: bounds, cornerRadius: 8.0)
    }

    // MARK: Boilerplate

    private let maskLayer = CAShapeLayer()
    private let previewImageView = GalleryDocumentPreviewImageView()

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
