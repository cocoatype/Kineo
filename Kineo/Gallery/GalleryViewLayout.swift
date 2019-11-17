//  Created by Geoff Pado on 11/6/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import UIKit

class GalleryViewLayout: UICollectionViewFlowLayout {
    override init() {
        super.init()
    }

    override func prepare() {
        guard let collectionViewBounds = collectionView?.bounds else { return }

        itemSize = CGSize(width: Self.cellWidth, height: Self.cellWidth)
        minimumInteritemSpacing = Self.spacing
        minimumLineSpacing = Self.spacing

        let numberItems = Int(collectionViewBounds.width / (Self.cellWidth + Self.spacing))
        let totalWidth = (numberItems * (Self.cellWidth + Self.spacing)) - Self.spacing
        let sideWidth = floor((collectionViewBounds.width - totalWidth) / 2) - 1

        sectionInset = UIEdgeInsets(top: Self.spacing, left: sideWidth, bottom: Self.spacing, right: sideWidth)
    }

    // MARK: Boilerplate

    private static let cellWidth = CGFloat(220.0)
    private static let spacing = CGFloat(50.0)

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let className = String(describing: type(of: self))
        fatalError("\(className) does not implement init(coder:)")
    }
}

private func * (lhs: Int, rhs: CGFloat) -> CGFloat {
    return CGFloat(lhs) * rhs
}
