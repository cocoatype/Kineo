//  Created by Geoff Pado on 11/6/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import UIKit

class GalleryViewLayout: UICollectionViewFlowLayout {
    static func horizontalInset(for bounds: CGRect) -> CGFloat {
        let numberItems = Int(bounds.width / (Self.cellWidth + Self.spacing))
        let totalWidth = (numberItems * (Self.cellWidth + Self.spacing)) - Self.spacing
        return floor((bounds.width - totalWidth) / 2) - 1
    }

    override func prepare() {
        guard let collectionViewBounds = collectionView?.bounds else { return }
        let sideWidth = Self.horizontalInset(for: collectionViewBounds)

        itemSize = CGSize(width: Self.cellWidth, height: Self.cellWidth)
        minimumInteritemSpacing = Self.spacing
        minimumLineSpacing = Self.spacing
        sectionInset = UIEdgeInsets(top: Self.spacing, left: sideWidth, bottom: Self.spacing, right: sideWidth)
    }

    // MARK: Boilerplate

    private static let cellWidth = CGFloat(256.0)
    private static let spacing = CGFloat(20.0)
}

private func * (lhs: Int, rhs: CGFloat) -> CGFloat {
    return CGFloat(lhs) * rhs
}
