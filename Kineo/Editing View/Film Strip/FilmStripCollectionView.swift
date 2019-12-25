//  Created by Geoff Pado on 12/24/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import UIKit

class FilmStripCollectionView: UICollectionView {
    init() {
        super.init(frame: .zero, collectionViewLayout: FilmStripCollectionViewLayout())

        backgroundColor = .filmStripBackground
        layer.cornerRadius = 10
        translatesAutoresizingMaskIntoConstraints = false

        register(FilmStripExistingPageCell.self, forCellWithReuseIdentifier: FilmStripExistingPageCell.identifier)
        register(FilmStripNewPageCell.self, forCellWithReuseIdentifier: FilmStripNewPageCell.identifier)
    }

    // MARK: Boilerplate

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
