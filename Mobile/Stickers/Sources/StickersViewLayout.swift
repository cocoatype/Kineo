//  Created by Geoff Pado on 3/15/20.
//  Copyright © 2020 Cocoatype, LLC. All rights reserved.

import UIKit

private func * (lhs: Int, rhs: CGFloat) -> CGFloat {
    return CGFloat(lhs) * rhs
}

class StickersViewLayout: UICollectionViewCompositionalLayout {
    init(void: Void = ()) {
        super.init(sectionProvider: { _, environment in
            return StickersViewLayoutSection(containerWidth: environment.container.contentSize.width)
        })
    }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}

class StickersViewLayoutSection: NSCollectionLayoutSection {
    convenience init(containerWidth: CGFloat) {
        self.init(group: StickersViewLayoutGroup.standardGroup())
        let spacing = Self.standardSpacing
        interGroupSpacing = spacing
        contentInsets = NSDirectionalEdgeInsets(top: spacing / 2, leading: 0, bottom: spacing / 2, trailing: 0)
    }

    static let standardSpacing = CGFloat(22)
}

class StickersViewLayoutGroup: NSCollectionLayoutGroup {
    class func standardGroup() -> StickersViewLayoutGroup {
        let group = StickersViewLayoutGroup.custom(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(Self.cellDimension))) { environment -> [NSCollectionLayoutGroupCustomItem] in
            let size = environment.container.contentSize
            let cellDimension = Self.cellDimension
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

    private static let cellDimension = CGFloat(136)
    private static let spacing = StickersViewLayoutSection.standardSpacing
}
