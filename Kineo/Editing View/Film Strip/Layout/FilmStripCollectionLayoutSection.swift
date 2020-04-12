//  Created by Geoff Pado on 1/23/20.
//  Copyright © 2020 Cocoatype, LLC. All rights reserved.

import UIKit

class FilmStripCollectionLayoutSection: NSCollectionLayoutSection {
    convenience init(void: Void = ()) {
        self.init(group: FilmStripCollectionLayoutGroup.standardGroup())
        interGroupSpacing = Self.standardSpacing
        contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4)
    }

    static let standardSpacing = CGFloat(4)
}
