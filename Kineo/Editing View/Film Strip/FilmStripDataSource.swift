//  Created by Geoff Pado on 12/24/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import UIKit

class FilmStripDataSource: NSObject, UICollectionViewDataSource {
    init(dataSource: EditingViewDataSource) {
        self.dataSource = dataSource
    }

    func isNewPage(_ indexPath: IndexPath) -> Bool {
        return indexPath.item == dataSource.pageCount
    }

    // MARK: UICollectionViewDataSource

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.pageCount + 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if isNewPage(indexPath) {
            return newPageCell(in: collectionView, forItemAt: indexPath)
        } else {
            return existingPageCell(in: collectionView, forItemAt: indexPath)
        }
    }

    private func existingPageCell(in collectionView: UICollectionView, forItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilmStripExistingPageCell.identifier, for: indexPath)

        guard let existingPageCell = cell as? FilmStripExistingPageCell else {
            assertionFailure("Cell was not expected type: \(cell)")
            return cell
        }

        existingPageCell.page = dataSource.page(at: indexPath.item)
        return existingPageCell
    }

    private func newPageCell(in collectionView: UICollectionView, forItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: FilmStripNewPageCell.identifier, for: indexPath)
    }

    // MARK: Boilerplate

    private let dataSource: EditingViewDataSource
}
