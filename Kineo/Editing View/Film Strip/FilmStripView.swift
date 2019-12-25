//  Created by Geoff Pado on 12/24/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import UIKit

class FilmStripView: UIControl, UICollectionViewDelegate {
    init(dataSource: EditingViewDataSource) {
        self.dataSource = FilmStripDataSource(dataSource: dataSource)
        super.init(frame: .zero)

        backgroundColor = .filmStripBackground
        clipsToBounds = false
        layer.cornerRadius = 10
        translatesAutoresizingMaskIntoConstraints = false

        collectionView.dataSource = self.dataSource
        collectionView.delegate = self
        addSubview(collectionView)
        addSubview(indicator)

        NSLayoutConstraint.activate([
            collectionView.widthAnchor.constraint(equalTo: widthAnchor),
            collectionView.heightAnchor.constraint(equalTo: heightAnchor),
            collectionView.centerXAnchor.constraint(equalTo: centerXAnchor),
            collectionView.centerYAnchor.constraint(equalTo: centerYAnchor),
            indicator.centerXAnchor.constraint(equalTo: trailingAnchor),
            indicator.topAnchor.constraint(equalTo: topAnchor, constant: 8)
        ])
    }

    func reloadData() {
        collectionView.reloadData()
    }

    // MARK: UICollectionViewDelegate

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if dataSource.isNewPage(indexPath) {
            sendAction(#selector(EditingViewController.addNewPage), to: nil, for: nil)
        } else {
            sendAction(#selector(EditingViewController.navigateToPage(_:)), to: nil, for: nil)
        }
    }

    var selectedIndex: Int? { return collectionView.indexPathsForSelectedItems?.first?.item }

    // MARK: Boilerplate

    private let collectionView = FilmStripCollectionView()
    private let dataSource: FilmStripDataSource
    private let indicator = FilmStripIndicator()

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
