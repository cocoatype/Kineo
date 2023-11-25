//  Created by Geoff Pado on 9/5/22.
//  Copyright © 2022 Cocoatype, LLC. All rights reserved.

import Core
import UIKit

class GalleryView: UIControl {
    init() {
        super.init(frame: .zero)

        addSubview(collectionView)
        addSubview(helpButton)

        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            helpButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -11),
            helpButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 11)
        ])
    }

    // MARK: Passthrough Properties

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
        set(newDelegate) { collectionView.dragDelegate = newDelegate }
    }

    func deleteItems(at indexPaths: [IndexPath]) {
        collectionView.deleteItems(at: indexPaths)
    }

    func cellForItem(at indexPath: IndexPath) -> UICollectionViewCell? {
        return collectionView.cellForItem(at: indexPath)
    }

    func reloadData() { collectionView.reloadData() }

    var selectedCell: UICollectionViewCell? {
        guard let selectedIndex = collectionView.indexPathsForSelectedItems?.first else { return nil }
        return collectionView.cellForItem(at: selectedIndex)
    }

    func scroll(to indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: .centeredVertically, animated: false)
        collectionView.layoutIfNeeded()
    }

    // MARK: Boilerplate

    private let collectionView = GalleryCollectionView()
    private let helpButton = HelpButton()

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
