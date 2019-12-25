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
        let itemsCount = collectionView.numberOfItems(inSection: 0) - 2
        let contentWidth = collectionView.bounds.width

        let itemsHeight = CGFloat(itemsCount) * (itemSize.height + minimumLineSpacing)
        let viewHeight = collectionView.bounds.height
        let contentHeight = itemsHeight + viewHeight
        return CGSize(width: contentWidth, height: contentHeight)
    }

    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        let targetItemIndex = indexOfItem(atContentOffset: proposedContentOffset)
        let targetOffset = CGFloat(targetItemIndex) * spacePerItem
        return CGPoint(x: proposedContentOffset.x, y: targetOffset)
    }

    func contentOffset(forItemAt index: Int) -> CGPoint {
        let verticalOffset = floor(CGFloat(index) * spacePerItem)
        return CGPoint(x: 0, y: verticalOffset)
    }

    func indexOfItem(atContentOffset contentOffset: CGPoint) -> Int {
        return Int(round(contentOffset.y / spacePerItem))
    }

    // MARK: Boilerplate

    private var spacePerItem: CGFloat { itemSize.height + minimumLineSpacing }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
