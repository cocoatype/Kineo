//  Created by Geoff Pado on 7/21/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import UIKit

class GalleryView: UIView {
    init() {
        super.init(frame: .zero)

        addSubview(collectionView)
        addSubview(sidebarView)

        NSLayoutConstraint.activate([
            sidebarView.leadingAnchor.constraint(equalTo: leadingAnchor),
            sidebarView.widthAnchor.constraint(equalToConstant: SidebarView.standardWidth),
            sidebarView.topAnchor.constraint(equalTo: topAnchor),
            sidebarView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: sidebarView.trailingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    // MARK: Collection View

    var dataSource: UICollectionViewDataSource? {
        get { return collectionView.dataSource }
        set(newDataSource) { collectionView.dataSource = newDataSource }
    }

    var delegate: UICollectionViewDelegate? {
        get { return collectionView.delegate }
        set(newDelegate) { collectionView.delegate = newDelegate }
    }

    var dragDelegate: UICollectionViewDragDelegate? {
        get { return collectionView.dragDelegate }
        set(newDragDelegate) { collectionView.dragDelegate = newDragDelegate }
    }

    // MARK: Boilerplate

    private let collectionView = GalleryCollectionView()
    private let sidebarView = SidebarView()

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
