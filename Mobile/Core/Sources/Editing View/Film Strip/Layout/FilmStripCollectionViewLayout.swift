//  Created by Geoff Pado on 1/22/20.
//  Copyright © 2020 Cocoatype, LLC. All rights reserved.

import UIKit

class FilmStripCollectionViewLayout: UICollectionViewCompositionalLayout {
    init(scrollDirection: UICollectionView.ScrollDirection = .vertical) {
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        configuration.scrollDirection = scrollDirection
        super.init(section: FilmStripCollectionLayoutSection(), configuration: configuration)
    }

    override var collectionViewContentSize: CGSize {
        guard let collectionView = collectionView else { return .zero }
        let minItemsCount = 2 // always show 2+ items: the current page and new page button
        let itemsCount = collectionView.numberOfItems(inSection: 0) - minItemsCount
        let totalItemsSpace = CGFloat(itemsCount) * spacePerItem
        var finalSize = collectionView.bounds.size

        switch scrollDirection {
        case .vertical: finalSize.height += totalItemsSpace
        case .horizontal: finalSize.width += totalItemsSpace
        @unknown default: break
        }

        return finalSize
    }

    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        let targetItemIndex = indexOfItem(atContentOffset: proposedContentOffset)
        let targetDelta = CGFloat(targetItemIndex) * spacePerItem
        var finalOffset = proposedContentOffset

        switch scrollDirection {
        case .vertical: finalOffset.y = targetDelta
        case .horizontal: finalOffset.x = targetDelta
        @unknown default: break
        }

        return finalOffset
    }

    func contentOffset(forItemAt index: Int) -> CGPoint {
        let delta = floor(CGFloat(index) * spacePerItem)
        switch scrollDirection {
        case .vertical: return CGPoint(x: 0, y: delta)
        case .horizontal: return CGPoint(x: delta, y: 0)
        @unknown default: return .zero
        }
    }

    func indexOfItem(atContentOffset contentOffset: CGPoint) -> Int {
        let relevantDistance: Double = switch scrollDirection {
        case .vertical: contentOffset.y
        case .horizontal: contentOffset.x
        @unknown default: .zero
        }

        let proposedIndex = Int(round(relevantDistance / spacePerItem))
        let itemsCount = collectionView?.numberOfItems(inSection: 0) ?? 0

        return max(min(proposedIndex, itemsCount), 0)
    }

    // MARK: Boilerplate

    private var spacePerItem: CGFloat {
        return FilmStripCollectionLayoutSize().widthDimension.dimension + FilmStripCollectionLayoutSection.standardSpacing
    }

    var scrollDirection: UICollectionView.ScrollDirection {
        return configuration.scrollDirection
    }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
