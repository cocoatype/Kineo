//  Created by Geoff Pado on 11/10/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import StylePhone
import UIKit

class GalleryNewCollectionViewCell: UICollectionViewCell, UIPointerInteractionDelegate {
    override init(frame: CGRect) {
        super.init(frame: frame)
        accessibilityLabel = NSLocalizedString("GalleryNewCollectionViewCell.accessibilityLabel", comment: "Accessibility label for the new document cell")
        accessibilityTraits = [.button]
        backgroundColor = .clear
        isAccessibilityElement = true

        contentView.addSubview(imageView)

        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 66),
            imageView.heightAnchor.constraint(equalToConstant: 66),
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])

        addPointerInteraction()
    }

    override func draw(_ rect: CGRect) {
        let borderRect = bounds.insetBy(dx: 2, dy: 2)
        let borderPath = UIBezierPath(roundedRect: borderRect, cornerRadius: 8)
        borderPath.setLineDash([4.0, 12.0], count: 2, phase: 0)
        borderPath.lineWidth = 4.0
        borderPath.lineCapStyle = .round
        Asset.newDocumentCellTint.color.setStroke()
        borderPath.stroke()
    }

    // MARK: Pointer Interactions

    private func addPointerInteraction() {
        guard #available(iOS 13.4, *) else { return }
        let interaction = UIPointerInteraction(delegate: self)
        addInteraction(interaction)
    }

    @available(iOS 13.4, *)
    func pointerInteraction(_ interaction: UIPointerInteraction, styleFor region: UIPointerRegion) -> UIPointerStyle? {
        let targetedPreview = UITargetedPreview(view: self)
        let pointerStyle = UIPointerStyle(effect: .lift(targetedPreview))
        return pointerStyle
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
