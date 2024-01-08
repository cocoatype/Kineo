//  Created by Geoff Pado on 11/6/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import UIKit

private func * (lhs: Int, rhs: CGFloat) -> CGFloat {
    return CGFloat(lhs) * rhs
}

class GalleryViewLayout: UICollectionViewCompositionalLayout {
    init() {
        super.init(sectionProvider: Self.sectionProvider(index:environment:))
    }

    private static func sectionProvider(index: Int, environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        GalleryViewLayoutSection(environment: environment)
    }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}

class GalleryViewLayoutSection: NSCollectionLayoutSection {
    convenience init(environment: NSCollectionLayoutEnvironment) {
        self.init(group: GalleryViewLayoutGroup.standardGroup(for: environment))
        let containerWidth = environment.container.contentSize.width
        let spacing = (containerWidth >= 350 ? Self.standardSpacing : Self.shrunkenSpacing)
        interGroupSpacing = spacing
        contentInsets = NSDirectionalEdgeInsets(top: spacing / 2, leading: 0, bottom: spacing / 2, trailing: 0)
    }

    static let standardSpacing = CGFloat(50)
    static let shrunkenSpacing = CGFloat(22)
}

class GalleryViewLayoutGroup: NSCollectionLayoutGroup {
    class func standardGroup(for environment: NSCollectionLayoutEnvironment) -> GalleryViewLayoutGroup {
        let group = GalleryViewLayoutGroup.custom(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(Self.cellDimension(for: environment))), itemProvider: Self.itemProvider(environment:))
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: Self.edgeInset, bottom: 0, trailing: Self.edgeInset)

        return group
    }

    private class func itemProvider(environment: NSCollectionLayoutEnvironment) -> [NSCollectionLayoutGroupCustomItem] {
        let size = environment.container.effectiveContentSize
        let cellDimension = Self.cellDimension(for: environment)
        let numberItems = max(Int(size.width / (cellDimension + Self.spacing)), 1)
        let totalWidth = (numberItems * (cellDimension + Self.spacing)) - Self.spacing
        let horizontalInset = floor((size.width - totalWidth) / 2) + Self.edgeInset

        let standardFrame = CGRect(origin: .zero, size: CGSize(width: cellDimension, height: cellDimension))
        return (0..<numberItems).map {
            var cellFrame = standardFrame
            cellFrame.origin.x = horizontalInset + ($0 * (cellDimension + Self.spacing))
            return NSCollectionLayoutGroupCustomItem(frame: cellFrame)
        }
    }

    private class func cellDimension(for environment: NSCollectionLayoutEnvironment) -> CGFloat {
        let size = environment.container.effectiveContentSize
        return (size.width >= 350 ? Self.cellDimension : Self.shrunkenCellDimension)
    }

    private static let cellDimension = CGFloat(220)
    private static let edgeInset = CGFloat(66)
    private static let shrunkenCellDimension = CGFloat(202)
    private static let spacing = GalleryViewLayoutSection.standardSpacing
}
