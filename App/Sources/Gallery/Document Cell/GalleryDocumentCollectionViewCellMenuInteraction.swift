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

            let confirmDeleteElement = UIAction(title: Self.deleteMenuItemTitle, image: Icons.ContextMenu.delete, attributes: [.destructive])  { _ in
                delegate.deleteAnimation(at: indexPath)
            }
            let deleteElement = UIMenu(title: Self.deleteMenuItemTitle, image: Icons.ContextMenu.delete, options: [.destructive], children: [confirmDeleteElement])
            let deleteSection = UIMenu(title: "", options: .displayInline, children: [deleteElement])

            let windowElement = UIAction(title: Self.windowMenuItemTitle, image: Icons.ContextMenu.window) { _ in
                delegate.openAnimationInNewWindow(at: indexPath)
            }

            let menuItems = (UIApplication.shared.supportsMultipleScenes ?
                [shareElement, windowElement, deleteSection] :
                [shareElement, deleteSection])

            return UIMenu(title: "", children: menuItems)
        }
    }

    private static let deleteMenuItemTitle = NSLocalizedString("GalleryDocumentCollectionViewCellMenuConfigurationProvider.deleteMenuItemTitle", comment: "Menu item title for deleting an animation")
    private static let exportMenuItemTitle = NSLocalizedString("GalleryDocumentCollectionViewCellMenuConfigurationProvider.exportMenuItemTitle", comment: "Menu item title for exporting an animation")
    private static let windowMenuItemTitle = NSLocalizedString("GalleryDocumentCollectionViewCellMenuConfigurationProvider.windowMenuItemTitle", comment: "Menu item title for exporting an animation")
}

class GalleryDocumentCollectionViewCellContextMenuConfiguration: UIContextMenuConfiguration {
    var indexPath: IndexPath?
}
