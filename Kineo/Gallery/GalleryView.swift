//  Created by Geoff Pado on 7/21/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import UIKit

class GalleryView: UICollectionView {
    init() {
        let layout = GalleryViewLayout()
        super.init(frame: .zero, collectionViewLayout: layout)

        register(GalleryDocumentCollectionViewCell.self, forCellWithReuseIdentifier: GalleryDocumentCollectionViewCell.identifier)
        register(GalleryNewCollectionViewCell.self, forCellWithReuseIdentifier: GalleryNewCollectionViewCell.identifier)

        backgroundColor = .darkGray
    }

    // MARK: Boilerplate

    @available(*, unavailable, message: "This class does not implement init(coder:)")
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
