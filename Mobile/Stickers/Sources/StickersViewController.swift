//  Created by Geoff Pado on 12/18/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import Messages
import UIKit

class StickersViewController: MSMessagesAppViewController {
    override func loadView() {
        view = collectionView
    }

    // MARK: Boilerplate
    private lazy var collectionView: StickersCollectionView = {
        let collectionView = StickersCollectionView()
        collectionView.dataSource = dataSource
        collectionView.delegate = dataSource
        return collectionView
    }()
    private let dataSource = StickerDataSource()
}
