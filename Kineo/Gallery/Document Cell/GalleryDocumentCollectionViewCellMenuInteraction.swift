//  Created by Geoff Pado on 1/26/20.
//  Copyright © 2020 Cocoatype, LLC. All rights reserved.

import UIKit

class GalleryDocumentCollectionViewCellMenuInteraction: UIContextMenuInteraction {
    init(cell: GalleryDocumentCollectionViewCell) {
        provider = GalleryDocumentCollectionViewCellMenuConfigurationProvider(cell: cell)
        super.init(delegate: provider)
    }

    private let provider:  GalleryDocumentCollectionViewCellMenuConfigurationProvider
}

private class GalleryDocumentCollectionViewCellMenuConfigurationProvider: NSObject, UIContextMenuInteractionDelegate {
    init(cell: GalleryDocumentCollectionViewCell?) {
        self.cell = cell
    }

    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil, actionProvider: actionProvider(suggestedElements:))
    }

    private func actionProvider(suggestedElements: [UIMenuElement]) -> UIMenu? {
        let shareElement = UIAction(title: Self.exportMenuItemTitle, image: Icons.ContextMenu.export) { [weak self] _ in
                   UIApplication.shared.sendAction(#selector(GalleryViewController.exportAnimation(_:)), to: nil, from: self?.cell, for: nil)
               }

        let deleteElement = UIAction(title: Self.deleteMenuItemTitle, image: Icons.ContextMenu.delete, attributes: [.destructive])  { [weak self] _ in
                   UIApplication.shared.sendAction(#selector(GalleryViewController.deleteAnimation), to: nil, from: self?.cell, for: nil)
               }

        return UIMenu(title: "", children: [shareElement, deleteElement])
    }

    private static let deleteMenuItemTitle = NSLocalizedString("GalleryDocumentCollectionViewCellMenuConfigurationProvider.deleteMenuItemTitle", comment: "Menu item title for deleting an animation")
    private static let exportMenuItemTitle = NSLocalizedString("GalleryDocumentCollectionViewCellMenuConfigurationProvider.exportMenuItemTitle", comment: "Menu item title for exporting an animation")

    private weak var cell: GalleryDocumentCollectionViewCell?
}
