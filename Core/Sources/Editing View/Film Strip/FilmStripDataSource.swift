//  Created by Geoff Pado on 12/24/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import Data
import EditingState
import UIKit

class FilmStripDataSource: NSObject, UICollectionViewDataSource {
    init(statePublisher: EditingStatePublisher) {
        self.statePublisher = statePublisher
    }

    var latestState: EditingState { statePublisher.value }

    var currentPageIndex: Int { return latestState.currentPageIndex }

    func isNewPage(_ indexPath: IndexPath) -> Bool {
        indexPath.item == latestState.pageCount
    }

    func page(at indexPath: IndexPath) -> Page {
        latestState.page(at: indexPath.item)
    }

    // MARK: UICollectionViewDataSource

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return latestState.pageCount + 1
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

        existingPageCell.canvasBackgroundColor = latestState.canvasBackgroundColor
        existingPageCell.canvasBackgroundImageData = latestState.canvasBackgroundImageData
        existingPageCell.page = latestState.page(at: indexPath.item)
        return existingPageCell
    }

    private func newPageCell(in collectionView: UICollectionView, forItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: FilmStripNewPageCell.identifier, for: indexPath)
    }

    // MARK: Boilerplate

    private let statePublisher: EditingStatePublisher
}
