//  Created by Geoff Pado on 3/15/20.
//  Copyright © 2020 Cocoatype, LLC. All rights reserved.

import Messages
import UIKit

class StickerCellBackgroundView: UIView {
    init() {
        super.init(frame: .zero)
        backgroundColor = .canvasBackground
        translatesAutoresizingMaskIntoConstraints = false
        layer.mask = maskLayer

        stickerView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stickerView)

        NSLayoutConstraint.activate([
            stickerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stickerView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stickerView.widthAnchor.constraint(equalTo: widthAnchor),
            stickerView.heightAnchor.constraint(equalTo: heightAnchor)
        ])
    }

    var sticker: MSSticker? {
        get { return stickerView.sticker }
        set(newSticker) {
            stickerView.sticker = newSticker
        }
    }

    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        maskLayer.frame = layer.bounds
        maskLayer.path = currentPath.cgPath
    }

    private var currentPath: UIBezierPath {
        return UIBezierPath(roundedRect: bounds, cornerRadius: 8)
    }

    // MARK: Animation

    func startAnimating() {
        stickerView.startAnimating()
    }

    func stopAnimating() {
        stickerView.stopAnimating()
    }

    // MARK: Boilerplate
    private let maskLayer = CAShapeLayer()
    private let stickerView = MSStickerView()

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
