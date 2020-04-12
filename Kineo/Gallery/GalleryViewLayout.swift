//  Created by Geoff Pado on 11/6/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import UIKit

private func * (lhs: Int, rhs: CGFloat) -> CGFloat {
    return CGFloat(lhs) * rhs
}

class GalleryViewLayout: UICollectionViewCompositionalLayout {
    init(void: Void = ()) {
        super.init(sectionProvider: { _, environment in
            return GalleryViewLayoutSection(containerWidth: environment.container.contentSize.width)
        })
    }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}

class GalleryViewLayoutSection: NSCollectionLayoutSection {
    convenience init(containerWidth: CGFloat) {
        self.init(group: GalleryViewLayoutGroup.standardGroup())
        let spacing = (containerWidth >= 350 ? Self.standardSpacing : Self.shrunkenSpacing)
        interGroupSpacing = spacing
        contentInsets = NSDirectionalEdgeInsets(top: spacing / 2, leading: 0, bottom: spacing / 2, trailing: 0)
    }

    static let standardSpacing = CGFloat(50)
    static let shrunkenSpacing = CGFloat(22)
}

class GalleryViewLayoutGroup: NSCollectionLayoutGroup {
    class func standardGroup() -> GalleryViewLayoutGroup {
        let group = GalleryViewLayoutGroup.custom(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(Self.cellDimension))) { environment -> [NSCollectionLayoutGroupCustomItem] in
            let size = environment.container.contentSize
            let cellDimension = (size.width >= 350 ? Self.cellDimension : Self.shrunkenCellDimension)
            let numberItems = Int(size.width / (cellDimension + Self.spacing))
            let totalWidth = (numberItems * (cellDimension + Self.spacing)) - Self.spacing
            let horizontalInset = floor((size.width - totalWidth) / 2)

            let standardFrame = CGRect(origin: .zero, size: CGSize(width: cellDimension, height: cellDimension))
            return (0..<numberItems).map {
                var cellFrame = standardFrame
                cellFrame.origin.x = horizontalInset + ($0 * (cellDimension + Self.spacing))
                return NSCollectionLayoutGroupCustomItem(frame: cellFrame)
            }
        }

        return group
    }

    private static let cellDimension = CGFloat(220)
    private static let shrunkenCellDimension = CGFloat(202)
    private static let spacing = GalleryViewLayoutSection.standardSpacing
}
