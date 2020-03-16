//  Created by Geoff Pado on 3/15/20.
//  Copyright © 2020 Cocoatype, LLC. All rights reserved.

import UIKit

class StickersCollectionView: UICollectionView {
    init() {
        let layout = StickersViewLayout()
        super.init(frame: .zero, collectionViewLayout: layout)

        backgroundColor = .appBackground
        register(StickerCell.self, forCellWithReuseIdentifier: StickerCell.identifier)
    }

    // MARK: Boilerplate

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
