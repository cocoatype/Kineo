//  Created by Geoff Pado on 12/16/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import StylePhone
import UIKit

class GalleryCollectionView: UICollectionView {
    init() {
        let layout = GalleryViewLayout()
        super.init(frame: .zero, collectionViewLayout: layout)

        contentInsetAdjustmentBehavior = .always
        translatesAutoresizingMaskIntoConstraints = false

        register(GalleryDocumentCollectionViewCell.self, forCellWithReuseIdentifier: GalleryDocumentCollectionViewCell.identifier)
        register(GalleryNewCollectionViewCell.self, forCellWithReuseIdentifier: GalleryNewCollectionViewCell.identifier)

        backgroundColor = Asset.background.color
    }

    // MARK: Boilerplate

    @available(*, unavailable, message: "This class does not implement init(coder:)")
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
