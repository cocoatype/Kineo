//  Created by Geoff Pado on 7/21/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import Core
import DataPhone
import UIKit

class GalleryViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDragDelegate {
    init() {
        super.init(nibName: nil, bundle: nil)
        cloudSyncObserver = NotificationCenter.default.addObserver(forName: CloudCoordinator.syncDidComplete, object: nil, queue: .main, using: { [weak self] _ in
            self?.galleryView?.reloadData()
        })
        deleteObserver = NotificationCenter.default.addObserver(forName: Self.didDeleteItem, object: nil, queue: .main, using: { [weak self] notification in
            let sender = (notification.object as? GalleryViewController)
            guard sender != self, let indexPath = (notification.userInfo?[Self.indexPathKey] as? IndexPath) else { self?.galleryView?.reloadData(); return }
            self?.galleryView?.deleteItems(at: [indexPath])
        })
    }

    override func loadView() {
        let galleryView = GalleryView()
        galleryView.dataSource = dataSource
        galleryView.delegate = self
        galleryView.dragDelegate = self
        view = galleryView
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        cloudCoordinator.performSync()
    }

    private func presentAnimation(at indexPath: IndexPath) {
        // TODO (#18): Show some kind of error if reading the document throws
        do {
            let document = try dataSource.document(at: indexPath)
            let selectionEvent = GallerySelectionEvent(document: document)

            galleryView?.sendAction(#selector(SceneViewController.showEditingView(_:for:)), to: nil, for: selectionEvent)
        } catch {
            print(String(describing: error))
        }
    }

    // MARK: Key Commands

    override var keyCommands: [UIKeyCommand]? {
        let helpCommand = UIKeyCommand(title: Self.helpKeyCommandTitle, action: #selector(SceneViewController.presentHelp), input: "?", modifierFlags: [.command])
        let settingsCommand = UIKeyCommand(title: Self.settingsKeyCommandTitle, action: #selector(SceneViewController.presentHelp), input: ",", modifierFlags: [.command])
        let newDocumentCommand = UIKeyCommand(title: Self.newDocumentKeyCommandTitle, action: #selector(createNewAnimation), input: "N", modifierFlags: [.command])
        return [helpCommand, settingsCommand, newDocumentCommand]
    }

    @objc private func createNewAnimation() {
        presentAnimation(at: IndexPath(item: 0, section: 0))
    }

    private static let helpKeyCommandTitle = NSLocalizedString("GalleryViewController.helpKeyCommandTitle", comment: "Key command title for displaying help")
    private static let settingsKeyCommandTitle = NSLocalizedString("GalleryViewController.settingsKeyCommandTitle", comment: "Key command title for displaying settings")
    private static let newDocumentKeyCommandTitle = NSLocalizedString("GalleryViewController.newDocumentKeyCommandTitle", comment: "Key command title for creating a new animation")

    // MARK: Context Menu Actions

    func backupAnimation(at indexPath: IndexPath) {
        let documentURL = dataSource.url(forDocumentAt: indexPath)
        let shareController = UIActivityViewController(activityItems: [documentURL], applicationActivities: nil)
        shareController.popoverPresentationController?.sourceView = galleryView?.cellForItem(at: indexPath)
        present(shareController, animated: true)
    }

    func deleteAnimation(at indexPath: IndexPath) {
        do {
            try dataSource.deleteDocument(at: indexPath)
            galleryView?.deleteItems(at: [indexPath])
            NotificationCenter.default.post(name: Self.didDeleteItem, object: self, userInfo: [Self.indexPathKey: indexPath])
        } catch {}
    }

    func exportAnimation(at indexPath: IndexPath) {
        guard let document = try? dataSource.document(at: indexPath) else { return }
        let editingViewController = ExportEditingNavigationController(document: document)
        present(editingViewController, animated: true, completion: nil)
    }

    func openAnimationInNewWindow(at indexPath: IndexPath) {
        do {
            let document = try dataSource.document(at: indexPath)
            let userActivity = EditingUserActivity(document: document)
            UIApplication.shared.requestSceneSessionActivation(nil, userActivity: userActivity, options: nil, errorHandler: nil)
        } catch { return }
    }

    func previewViewController(forDocumentAt indexPath: IndexPath) -> UIViewController? {
        guard let document = try? dataSource.document(at: indexPath) else { return nil }

        return GalleryDocumentPreviewViewController(document: document)
    }

    func cell(for document: Document) -> UICollectionViewCell? {
        guard let galleryView = galleryView else { fatalError("GalleryViewController has no GalleryView") }
        let indexPath = dataSource.indexPath(of: document) ?? IndexPath(item: 0, section: 0)
        if let cell = galleryView.cellForItem(at: indexPath) {
            return cell
        } else {
            galleryView.scroll(to: indexPath)
            return galleryView.cellForItem(at: indexPath)
        }
    }

    // MARK: UICollectionViewDelegate

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presentAnimation(at: indexPath)
    }

    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        return dataSource.contextMenuConfiguration(forItemAt: indexPath, delegate: self)
    }

    func collectionView(_ collectionView: UICollectionView, willPerformPreviewActionForMenuWith configuration: UIContextMenuConfiguration, animator: UIContextMenuInteractionCommitAnimating) {
        guard let indexPath = (configuration as? GalleryDocumentCollectionViewCellContextMenuConfiguration)?.indexPath else { return }
        presentAnimation(at: indexPath)
    }

    func collectionView(_ collectionView: UICollectionView, previewForDismissingContextMenuWithConfiguration configuration: UIContextMenuConfiguration) -> UITargetedPreview? {
        guard let indexPath = (configuration as? GalleryDocumentCollectionViewCellContextMenuConfiguration)?.indexPath, let  cell = galleryView?.cellForItem(at: indexPath) else { return nil }
        return UITargetedPreview(view: cell)
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

    // MARK: Notifications

    private static let didDeleteItem = Notification.Name("GalleryViewController.didDeleteItem")
    private static let indexPathKey = "GalleryViewController.indexPathKey"

    // MARK: Boilerplate

    private let cloudCoordinator = CloudCoordinator()
    private var cloudSyncObserver: Any?
    private let dataSource = GalleryViewDataSource()
    private var deleteObserver: Any?
    private var galleryView: GalleryView? { return view as? GalleryView }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }

    deinit {
        cloudSyncObserver.map(NotificationCenter.default.removeObserver(_:))
        deleteObserver.map(NotificationCenter.default.removeObserver(_:))
    }
}

class GalleryCreationEvent: UIEvent {}
