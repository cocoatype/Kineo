//  Created by Geoff Pado on 11/6/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import UIKit

class GalleryDocumentCollectionViewCell: UICollectionViewCell, UIPointerInteractionDelegate {
    override init(frame: CGRect) {
        super.init(frame: frame)
        accessibilityLabel = NSLocalizedString("GalleryDocumentCollectionViewCell.accessibilityLabel", comment: "Accessibility label for the document cell")
        accessibilityTraits = [.button]
        backgroundColor = .clear
        clipsToBounds = false
        isAccessibilityElement = true
        isOpaque = true

        contentView.addSubview(canvasView)

        NSLayoutConstraint.activate([
            canvasView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            canvasView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            canvasView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            canvasView.heightAnchor.constraint(equalTo: contentView.heightAnchor)
        ])

        addPointerInteraction()
    }

    var modifiedDate = Date.distantPast {
        didSet {
            let format = NSLocalizedString("GalleryDocumentCollectionViewCell.accessibilityValueFormat", comment: "Format string for the document cell accessibility value")
            let dateString = Self.dateFormatter.string(from: modifiedDate)
            accessibilityValue = String(format: format, dateString)
        }
    }

    var previewImage: UIImage? {
        get { return canvasView.previewImage }
        set(newImage) { canvasView.previewImage = newImage }
    }

    // MARK: Accessibility

    private static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        return dateFormatter
    }()

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

    static let identifier = "GalleryDocumentCollectionViewCell.identifier"

    private let canvasView = GalleryDocumentCollectionViewCellBackgroundView()

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let className = String(describing: type(of: self))
        fatalError("\(className) does not implement init(coder:)")
    }
}
