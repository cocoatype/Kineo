//  Created by Geoff Pado on 12/24/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import UIKit

class FilmStripCollectionView: UICollectionView {
    init() {
        super.init(frame: .zero, collectionViewLayout: FilmStripCollectionViewLayout())

        backgroundColor = .filmStripBackground
        layer.cornerRadius = 10
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        translatesAutoresizingMaskIntoConstraints = false

        register(FilmStripExistingPageCell.self, forCellWithReuseIdentifier: FilmStripExistingPageCell.identifier)
        register(FilmStripNewPageCell.self, forCellWithReuseIdentifier: FilmStripNewPageCell.identifier)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let scrollDirection: UICollectionView.ScrollDirection
        if bounds.width > bounds.height {
            scrollDirection = .horizontal
        } else { scrollDirection = .vertical }

        if filmStripLayout?.scrollDirection != scrollDirection {
            collectionViewLayout = FilmStripCollectionViewLayout(scrollDirection: scrollDirection)
        }
    }

    var filmStripLayout: FilmStripCollectionViewLayout? { return collectionViewLayout as? FilmStripCollectionViewLayout }

    // MARK: Boilerplate

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
