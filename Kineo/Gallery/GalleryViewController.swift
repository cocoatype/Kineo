//  Created by Geoff Pado on 7/21/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import UIKit

class GalleryViewController: UIViewController, UICollectionViewDelegate {
    init() {
        super.init(nibName: nil, bundle: nil)
    }

    override func loadView() {
        let galleryView = GalleryView()
        galleryView.dataSource = dataSource
        galleryView.delegate = self
        view = galleryView
    }

    // MARK: UICollectionViewDelegate

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectionEvent = GallerySelectionEvent(document: dataSource.document(at: indexPath))
        UIApplication.shared.sendAction(#selector(SceneViewController.showEditingView(_:for:)), to: nil, from: self, for: selectionEvent)
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
