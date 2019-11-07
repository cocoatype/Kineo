//  Created by Geoff Pado on 11/6/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import UIKit

class GalleryViewDataSource: NSObject, UICollectionViewDataSource {
    func document(at indexPath: IndexPath) -> Document {
        guard indexPath != GalleryViewDataSource.newDocumentIndexPath else { return documentStore.newDocument() }

        let documentIndex = indexPath.item - 1
        return documentStore.document(at: documentIndex)
    }

    // MARK: UICollectionViewDataSource

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return documentStore.documentsCount + 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard indexPath.item != 0 else { return collectionView.dequeueReusableCell(withReuseIdentifier: GalleryNewCollectionViewCell.identifier, for: indexPath) }
        return collectionView.dequeueReusableCell(withReuseIdentifier: GalleryDocumentCollectionViewCell.identifier, for: indexPath)
    }

    // MARK: Boilerplate

    private let documentStore = DocumentStore()
    private static let newDocumentIndexPath = IndexPath(item: 0, section: 0)
}
