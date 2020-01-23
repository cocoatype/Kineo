//  Created by Geoff Pado on 1/23/20.
//  Copyright © 2020 Cocoatype, LLC. All rights reserved.

import UIKit

class FilmStripCollectionLayoutSize: NSCollectionLayoutSize {
    convenience init(void: Void = ()) {
        self.init(widthDimension: .absolute(Self.cellDimension), heightDimension: .absolute(Self.cellDimension))
    }

    private static let cellDimension = CGFloat(36)
}
