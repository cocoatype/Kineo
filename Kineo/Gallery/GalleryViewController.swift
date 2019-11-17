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

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}

class GalleryCreationEvent: UIEvent {}

class EditingUserActivity: NSUserActivity {
    public init(document: Document) {
        self.document = document
        super.init(activityType: Self.defaultActivityType)

        do {
            let documentData = try JSONEncoder().encode(document)
            userInfo = [EditingUserActivity.documentDataKey: documentData]
        } catch {}
    }

    public convenience init?(userActivity: NSUserActivity) {
        guard userActivity.activityType == EditingUserActivity.defaultActivityType, let documentData = (userActivity.userInfo?[EditingUserActivity.documentDataKey] as? Data), let document = try? JSONDecoder().decode(Document.self, from: documentData) else { return nil }

        self.init(document: document)
        title = userActivity.title
    }

    // MARK: Boilerplate

    private static let defaultActivityType = "com.flipbookapp.flickbook.editing"
    private static let documentDataKey = "EditingUserActivity.documentDataKey"

    let document: Document
}
