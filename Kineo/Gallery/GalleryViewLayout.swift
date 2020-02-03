//  Created by Geoff Pado on 11/6/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import UIKit

private func * (lhs: Int, rhs: CGFloat) -> CGFloat {
    return CGFloat(lhs) * rhs
}

class GalleryViewLayout: UICollectionViewCompositionalLayout {
    init(void: Void = ()) {
        super.init(section: GalleryViewLayoutSection())
    }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}

class GalleryViewLayoutSection: NSCollectionLayoutSection {
    convenience init(void: Void = ()) {
        self.init(group: GalleryViewLayoutGroup.standardGroup())
        interGroupSpacing = Self.standardSpacing
        contentInsets = NSDirectionalEdgeInsets(top: Self.standardSpacing, leading: 0, bottom: Self.standardSpacing, trailing: 0)
    }

    static let standardSpacing = CGFloat(50)
}

class GalleryViewLayoutGroup: NSCollectionLayoutGroup {
    class func standardGroup() -> GalleryViewLayoutGroup {
        let group = GalleryViewLayoutGroup.custom(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(Self.cellDimension))) { environment -> [NSCollectionLayoutGroupCustomItem] in
            let size = environment.container.contentSize
            let numberItems = Int(size.width / (Self.cellDimension + Self.spacing))
            let totalWidth = (numberItems * (Self.cellDimension + Self.spacing)) - Self.spacing
            let horizontalInset = floor((size.width - totalWidth) / 2)

            let standardFrame = CGRect(origin: .zero, size: CGSize(width: Self.cellDimension, height: Self.cellDimension))
            return (0..<numberItems).map {
                var cellFrame = standardFrame
                cellFrame.origin.x = horizontalInset + ($0 * (Self.cellDimension + Self.spacing))
                return NSCollectionLayoutGroupCustomItem(frame: cellFrame)
            }
        }

        return group
    }

    private static let cellDimension = CGFloat(220)
    private static let spacing = GalleryViewLayoutSection.standardSpacing
}
