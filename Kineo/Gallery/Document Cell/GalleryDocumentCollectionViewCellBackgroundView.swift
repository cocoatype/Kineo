//  Created by Geoff Pado on 11/10/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import UIKit

class GalleryDocumentCollectionViewCellBackgroundView: UIView {
    init() {
        super.init(frame: .zero)
        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = false
        layer.mask = maskLayer

        addSubview(titleContainer)

        NSLayoutConstraint.activate([
            titleContainer.topAnchor.constraint(equalTo: topAnchor),
            titleContainer.widthAnchor.constraint(equalTo: widthAnchor)
        ])
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
    private let titleContainer = GalleryDocumentCollectionViewCellTitleContainerView()

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
