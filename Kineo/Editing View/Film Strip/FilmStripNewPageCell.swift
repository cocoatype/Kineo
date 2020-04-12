//  Created by Geoff Pado on 12/24/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import UIKit

class FilmStripNewPageCell: UICollectionViewCell {
    static let identifier = "FilmStripNewPageCell.identifier"

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear

        contentView.addSubview(imageView)

        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            imageView.heightAnchor.constraint(equalTo: contentView.heightAnchor),
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }

    override func draw(_ rect: CGRect) {
        let borderRect = bounds.insetBy(dx: 0.5, dy: 0.5)
        let borderPath = UIBezierPath(roundedRect: borderRect, cornerRadius: 8)
        borderPath.setLineDash([4.0, 4.0], count: 2, phase: 0)
        borderPath.lineWidth = 1.0
        borderPath.lineCapStyle = .round
        UIColor.newCellTint.setStroke()
        borderPath.stroke()
    }

    // MARK: Boilerplate

    private let imageView = FilmStripNewPageImageView()

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
