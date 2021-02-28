//  Created by Geoff Pado on 12/24/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import Data
import UIKit

class FilmStripExistingPageCell: UICollectionViewCell, UIPointerInteractionDelegate, UIContextMenuInteractionDelegate {
    static let identifier = "FilmStripExistingPageCell.identifier"

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.addSubview(shadowView)
        contentView.addSubview(imageView)

        NSLayoutConstraint.activate([
            shadowView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            shadowView.heightAnchor.constraint(equalTo: contentView.heightAnchor),
            shadowView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            shadowView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            imageView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            imageView.heightAnchor.constraint(equalTo: contentView.heightAnchor),
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])

        addPointerInteraction()
        addContextMenuInteraction()
    }

    var page: Page? {
        didSet(oldPage) {
            guard page != oldPage else { return }
            guard let page = page else { imageView.image = nil; return }
            Self.generator.generateThumbnail(for: page.drawing) { [weak self] image, drawing in
                guard self?.page == page else { return }
                DispatchQueue.main.async {
                    self?.imageView.image = image
                }
            }
        }
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

    // MARK: Context Menu Iteraction

    private func addContextMenuInteraction() {
        let interaction = UIContextMenuInteraction(delegate: self)
        addInteraction(interaction)
    }

    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        guard let page = page, let pageData = try? JSONEncoder().encode(page) else { return nil }
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ in
            let menu = UIMenu(children: [
                UICommand(title: "Duplicate", image: UIImage(systemName: "plus.square.on.square"), action: #selector(EditingViewController.duplicatePage(_:)), propertyList: pageData),
                UICommand(title: "Delete", image: UIImage(systemName: "trash"), action: #selector(EditingViewController.deletePage(_:)), propertyList: pageData, attributes: .destructive)
            ])
            return menu
        }
    }

    // MARK: Boilerplate

    private static let generator = DrawingImageGenerator.shared
    private let imageView = FilmStripExistingPageImageView()
    private let shadowView = FilmStripExistingPageBackgroundView()

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
