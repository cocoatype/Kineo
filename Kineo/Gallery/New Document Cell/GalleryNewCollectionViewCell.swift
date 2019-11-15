//  Created by Geoff Pado on 11/10/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import UIKit

class GalleryNewCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear

        contentView.addSubview(imageView)

        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 66),
            imageView.heightAnchor.constraint(equalToConstant: 66),
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }

    override func draw(_ rect: CGRect) {
        let borderRect = bounds.insetBy(dx: 2, dy: 2)
        let borderPath = UIBezierPath(roundedRect: borderRect, cornerRadius: 8)
        borderPath.setLineDash([4.0, 12.0], count: 2, phase: 0)
        borderPath.lineWidth = 4.0
        borderPath.lineCapStyle = .round
        UIColor.newCellTint.setStroke()
        borderPath.stroke()
    }

    // MARK: Boilerplate

    static let identifier = "GalleryNewCollectionViewCell.identifier"

    private let imageView = GalleryNewDocumentImageView()

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let className = String(describing: type(of: self))
        fatalError("\(className) does not implement init(coder:)")
    }
}
