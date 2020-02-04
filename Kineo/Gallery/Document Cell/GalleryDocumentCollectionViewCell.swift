//  Created by Geoff Pado on 11/6/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import UIKit

class GalleryDocumentCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        clipsToBounds = false
        isOpaque = true

        contentView.layer.shadowColor = UIColor.appShadow.cgColor
        contentView.layer.shadowOffset = CGSize(width: 0, height: 2)
        contentView.layer.shadowOpacity = 1
        contentView.layer.shadowRadius = 3
        contentView.layer.shouldRasterize = true

        contentView.addSubview(canvasView)

        NSLayoutConstraint.activate([
            canvasView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            canvasView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            canvasView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            canvasView.heightAnchor.constraint(equalTo: contentView.heightAnchor)
        ])
    }

    var previewImage: UIImage? {
        get { return canvasView.previewImage }
        set(newImage) { canvasView.previewImage = newImage }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 8.0).cgPath
        contentView.layer.rasterizationScale = window?.windowScene?.screen.scale ?? UIScreen.main.scale
        contentView.layer.shouldRasterize = true
    }

    // MARK: Boilerplate

    static let identifier = "GalleryDocumentCollectionViewCell.identifier"

    private let canvasView = GalleryDocumentCollectionViewCellBackgroundView()

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let className = String(describing: type(of: self))
        fatalError("\(className) does not implement init(coder:)")
    }
}
