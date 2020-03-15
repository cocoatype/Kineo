//  Created by Geoff Pado on 3/15/20.
//  Copyright © 2020 Cocoatype, LLC. All rights reserved.

import Messages
import UIKit

class StickerCell: UICollectionViewCell {
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

    var sticker: MSSticker? {
        get { return canvasView.sticker }
        set(newSticker) {
            canvasView.sticker = newSticker
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 8).cgPath
    }

    // MARK: Animation

    func startAnimating() {
        canvasView.startAnimating()
    }

    func stopAnimating() {
        canvasView.stopAnimating()
    }

    // MARK: Boilerplate

    static let identifier = "StickerCell.identifier"

    private let canvasView = StickerCellBackgroundView()

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
