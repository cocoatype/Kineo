//  Created by Geoff Pado on 12/24/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import UIKit

class FilmStripCollectionViewLayout: UICollectionViewFlowLayout {
    override init() {
        super.init()
        sectionInset = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
        itemSize = CGSize(width: 36, height: 36)
        minimumLineSpacing = 4
        minimumInteritemSpacing = 4
    }

    override var collectionViewContentSize: CGSize {
        guard let collectionView = collectionView else { return .zero }
        let minItemsCount = 2 // always show 2+ items: the current page and new page button
        let itemsCount = collectionView.numberOfItems(inSection: 0) - minItemsCount
        let totalItemsSpace = CGFloat(itemsCount) * spacePerItem
        var finalSize = collectionView.bounds.size

        switch alignment {
        case .vertical: finalSize.height += totalItemsSpace
        case .horizontal: finalSize.width += totalItemsSpace
        }

        return finalSize
    }

    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        let targetItemIndex = indexOfItem(atContentOffset: proposedContentOffset)
        let targetDelta = CGFloat(targetItemIndex) * spacePerItem
        var finalOffset = proposedContentOffset

        switch alignment {
        case .vertical: finalOffset.y = targetDelta
        case .horizontal: finalOffset.x = targetDelta
        }

        return finalOffset
    }

    func contentOffset(forItemAt index: Int) -> CGPoint {
        let delta = floor(CGFloat(index) * spacePerItem)
        switch alignment {
        case .vertical: return CGPoint(x: 0, y: delta)
        case .horizontal: return CGPoint(x: delta, y: 0)
        }
    }

    func indexOfItem(atContentOffset contentOffset: CGPoint) -> Int {
        var relevantDistance: CGFloat
        switch alignment {
        case .vertical: relevantDistance = contentOffset.y
        case .horizontal: relevantDistance = contentOffset.x
        }
        return Int(round(relevantDistance / spacePerItem))
    }

    // MARK: Boilerplate

    private var alignment: Alignment {
        guard let collectionView = collectionView else { return .vertical }
        if collectionView.bounds.width > collectionView.bounds.height {
            return .horizontal
        } else {
            return .vertical
        }
    }

    private var spacePerItem: CGFloat {
        switch alignment {
        case .vertical: return itemSize.height + minimumLineSpacing
        case .horizontal: return itemSize.width + minimumInteritemSpacing
        }
    }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }

    private enum Alignment {
        case horizontal, vertical
    }
}
