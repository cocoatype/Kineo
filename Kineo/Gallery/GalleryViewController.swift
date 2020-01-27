//  Created by Geoff Pado on 7/21/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import UIKit

class GalleryViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDragDelegate {
    init() {
        super.init(nibName: nil, bundle: nil)
    }

    override func loadView() {
        let galleryView = GalleryView()
        galleryView.dataSource = dataSource
        galleryView.delegate = self
        galleryView.dragDelegate = self
        view = galleryView
    }

    // MARK: Context Menu Actions

    @objc func deleteAnimation(_ sender: GalleryDocumentCollectionViewCell?) {
        guard let cell = sender, let indexPath = galleryView?.indexPath(for: cell) else { return }

        do {
            try dataSource.deleteDocument(at: indexPath)
            galleryView?.deleteItem(at: indexPath)
        } catch {}
    }

    @objc func exportAnimation(_ sender: GalleryDocumentCollectionViewCell?) {
        guard let cell = sender, let indexPath = galleryView?.indexPath(for: cell), let document = try? dataSource.document(at: indexPath) else { return }

        dump(document)
    }

    // MARK: UICollectionViewDelegate

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // TODO (#18): Show some kind of error if reading the document throws
        guard let document = try? dataSource.document(at: indexPath) else { return }
        let selectionEvent = GallerySelectionEvent(document: document)
        UIApplication.shared.sendAction(#selector(SceneViewController.showEditingView(_:for:)), to: nil, from: self, for: selectionEvent)
    }

    // MARK: UICollectionViewDragDelegate

    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        do {
            let document = try dataSource.document(at: indexPath)

            let userActivity = EditingUserActivity(document: document)
            let dragItemProvider = NSItemProvider(object: userActivity)

            let dragItem = UIDragItem(itemProvider: dragItemProvider)
            dragItem.localObject = document
            return [dragItem]
        } catch {
            return []
        }
    }

    // MARK: Boilerplate

    private let dataSource = GalleryViewDataSource()
    private var galleryView: GalleryView? { return view as? GalleryView }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}

class GalleryCreationEvent: UIEvent {}
