//  Created by Geoff Pado on 12/24/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import UIKit

class FilmStripDataSource: NSObject, UICollectionViewDataSource {
    init(dataSource: EditingViewDataSource) {
        self.dataSource = dataSource
    }

    // MARK: UICollectionViewDataSource

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.pageCount
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilmStripExistingPageCell.identifier, for: indexPath)
        guard let existingPageCell = cell as? FilmStripExistingPageCell else {
            assertionFailure("Cell was not expected type: \(cell)")
            return cell
        }

        existingPageCell.image = dataSource.thumbnail(forPageAt: indexPath.item)
        return existingPageCell
    }

    // MARK: Boilerplate

    private let dataSource: EditingViewDataSource
}
