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
            collectionView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])

        installIndicatorConstraints()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let indicatorSize = indicator.intrinsicContentSize
        var indicatorFrame = CGRect(origin: .zero, size: indicatorSize)
        if traitCollection.horizontalSizeClass == .compact {
            indicatorFrame.origin.y = bounds.minY - (indicatorSize.height / 2)
            indicatorFrame.origin.x = bounds.minX + 8
        } else {
            indicatorFrame.origin.x = bounds.maxX + (indicatorSize.width / 2)
            indicatorFrame.origin.y = bounds.minY + 8
        }

        indicator.frame = indicatorFrame
    }

    func reloadData() {
        collectionView.reloadData()
    }

    private func installIndicatorConstraints() {
        if traitCollection.horizontalSizeClass == .compact {
            NSLayoutConstraint.activate([
                indicator.centerYAnchor.constraint(equalTo: topAnchor),
                indicator.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8)
            ])
        } else {
            NSLayoutConstraint.activate([
                indicator.centerXAnchor.constraint(equalTo: trailingAnchor),
                indicator.topAnchor.constraint(equalTo: topAnchor, constant: 8)
            ])
        }
    }

    // MARK: UICollectionViewDelegate

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if dataSource.isNewPage(indexPath) {
            sendAction(#selector(EditingViewController.addNewPage), to: nil, for: nil)
        } else {
            sendAction(#selector(EditingViewController.navigateToPage(_:for:)), to: nil, for: PageNavigationEvent(pageIndex: indexPath.item))
        }

        collectionView.scrollToItem(at: indexPath, at: .top, animated: true)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard scrollView.isScrollUserInitiated, let layout = collectionView.collectionViewLayout as? FilmStripCollectionViewLayout else { return }
        let pageIndex = layout.indexOfItem(atContentOffset: scrollView.contentOffset)
        sendAction(#selector(EditingViewController.navigateToPage(_:for:)), to: nil, for: PageNavigationEvent(pageIndex: pageIndex))
    }

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

class PageNavigationEvent: UIEvent {
    let pageIndex: Int
    init(pageIndex: Int) {
        self.pageIndex = pageIndex
    }
}

private extension UIScrollView {
    var isScrollUserInitiated: Bool {
        return isTracking || isDragging || isDecelerating
    }
}
