//  Created by Geoff Pado on 11/6/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import Data
import UIKit

class GalleryViewDataSource: NSObject, UICollectionViewDataSource {
    func document(at indexPath: IndexPath) throws -> Document {
        guard indexPath != GalleryViewDataSource.newDocumentIndexPath else { return documentStore.newDocument() }

        let documentIndex = indexPath.item - 1
        return try documentStore.document(at: documentIndex)
    }

    func indexPath(of document: Document) -> IndexPath? {
        guard let index = documentStore.allIdentifiers.firstIndex(of: document.uuid) else { return nil }
        return IndexPath(item: index + 1, section: 0)
    }

    func modifiedDate(at indexPath: IndexPath) -> Date {
        guard indexPath != GalleryViewDataSource.newDocumentIndexPath else { return .distantPast }

        let documentIndex = indexPath.item - 1
        return documentStore.modifiedDate(at: documentIndex)
    }

    func previewImage(at indexPath: IndexPath) -> UIImage? {
        guard indexPath != GalleryViewDataSource.newDocumentIndexPath else { return nil }

        let documentIndex = indexPath.item - 1
        return documentStore.previewImage(at: documentIndex)
    }

    func deleteDocument(at indexPath: IndexPath) throws {
        let documentIndex = indexPath.item - 1
        try documentStore.deleteDocument(at: documentIndex)
    }

    func url(forDocumentAt indexPath: IndexPath) -> URL {
        let documentIndex = indexPath.item - 1
        return documentStore.url(forDocumentAt: documentIndex)
    }

    func contextMenuConfiguration(forItemAt indexPath: IndexPath, delegate: GalleryViewController) -> UIContextMenuConfiguration? {
        guard indexPath != Self.newDocumentIndexPath else { return nil }
        return GalleryDocumentCollectionViewCellContextMenuConfigurationFactory.configuration(for: indexPath, delegate: delegate)
    }

    // MARK: UICollectionViewDataSource

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return documentStore.documentsCount + 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard indexPath.item != 0 else { return newCollectionViewCell(in: collectionView, at: indexPath) }

        return documentCollectionViewCell(in: collectionView, at: indexPath)
    }

    private func newCollectionViewCell(in collectionView: UICollectionView, at indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: GalleryNewCollectionViewCell.identifier, for: indexPath)
    }

    private func documentCollectionViewCell(in collectionView: UICollectionView, at indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GalleryDocumentCollectionViewCell.identifier, for: indexPath)
        guard let documentCell = cell as? GalleryDocumentCollectionViewCell else {
            assertionFailure("Cell is incorrect type: \(cell), expected GalleryDocumentCollectionViewCell")
            return cell
        }

        documentCell.modifiedDate = modifiedDate(at: indexPath)
        documentCell.previewImage = previewImage(at: indexPath)

        return documentCell
    }

    // MARK: Boilerplate

    private let documentStore = DocumentStore()
    private static let newDocumentIndexPath = IndexPath(item: 0, section: 0)
}
