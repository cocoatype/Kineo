//  Created by Geoff Pado on 1/26/20.
//  Copyright © 2020 Cocoatype, LLC. All rights reserved.

import UIKit

enum GalleryDocumentCollectionViewCellContextMenuConfigurationFactory {
    static func configuration(for indexPath: IndexPath, delegate: GalleryViewController) -> UIContextMenuConfiguration {
        let configuration = GalleryDocumentCollectionViewCellContextMenuConfiguration(identifier: nil, previewProvider: previewProvider(for: indexPath, delegate: delegate), actionProvider: actionProvider(for: indexPath, delegate: delegate))
        configuration.indexPath = indexPath
        return configuration
    }

    private static func previewProvider(for indexPath: IndexPath, delegate: GalleryViewController) -> UIContextMenuContentPreviewProvider {
        return {
            return delegate.previewViewController(forDocumentAt: indexPath)
        }
    }

    private static func actionProvider(for indexPath: IndexPath, delegate: GalleryViewController) -> UIContextMenuActionProvider {
        return { _ in
            let shareElement = UIAction(title: Self.exportMenuItemTitle, image: Icons.ContextMenu.export) { _ in
                delegate.exportAnimation(at: indexPath)
            }

            let deleteElement = UIAction(title: Self.deleteMenuItemTitle, image: Icons.ContextMenu.delete, attributes: [.destructive])  { _ in
                delegate.deleteAnimation(at: indexPath)
            }

            return UIMenu(title: "", children: [shareElement, deleteElement])
        }
    }

    private static let deleteMenuItemTitle = NSLocalizedString("GalleryDocumentCollectionViewCellMenuConfigurationProvider.deleteMenuItemTitle", comment: "Menu item title for deleting an animation")
    private static let exportMenuItemTitle = NSLocalizedString("GalleryDocumentCollectionViewCellMenuConfigurationProvider.exportMenuItemTitle", comment: "Menu item title for exporting an animation")
}

class GalleryDocumentCollectionViewCellContextMenuConfiguration: UIContextMenuConfiguration {
    var indexPath: IndexPath?
}
