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

    private func presentAnimation(at indexPath: IndexPath) {
        // TODO (#18): Show some kind of error if reading the document throws
        guard let document = try? dataSource.document(at: indexPath) else { return }
        let selectionEvent = GallerySelectionEvent(document: document)
        UIApplication.shared.sendAction(#selector(SceneViewController.showEditingView(_:for:)), to: nil, from: self, for: selectionEvent)
    }

    @objc func presentHelp() {
        let alert = UIAlertController(title: "Please Do Not Press This Button Again", message: "This feature is currently unimplemented. It will do something more interesting in a later beta.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true)
    }

    // MARK: Context Menu Actions

    func deleteAnimation(at indexPath: IndexPath) {
        do {
            try dataSource.deleteDocument(at: indexPath)
            galleryView?.deleteItems(at: [indexPath])
        } catch {}
    }

    func exportAnimation(at indexPath: IndexPath) {
        guard let document = try? dataSource.document(at: indexPath), let activityController = ExportViewController(document: document, sourceView: galleryView?.cellForItem(at: indexPath)) else { return }

        present(activityController, animated: true, completion: nil)
    }

    func previewViewController(forDocumentAt indexPath: IndexPath) -> UIViewController? {
        guard let document = try? dataSource.document(at: indexPath) else { return nil }

        return GalleryDocumentPreviewViewController(document: document)
    }

    // MARK: UICollectionViewDelegate

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presentAnimation(at: indexPath)
    }

    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        return GalleryDocumentCollectionViewCellContextMenuConfigurationFactory.configuration(for: indexPath, delegate: self)
    }

    func collectionView(_ collectionView: UICollectionView, willPerformPreviewActionForMenuWith configuration: UIContextMenuConfiguration, animator: UIContextMenuInteractionCommitAnimating) {
        guard let indexPath = (configuration as? GalleryDocumentCollectionViewCellContextMenuConfiguration)?.indexPath else { return }
        presentAnimation(at: indexPath)
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
