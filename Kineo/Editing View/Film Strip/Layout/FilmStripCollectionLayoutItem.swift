//  Created by Geoff Pado on 1/23/20.
//  Copyright © 2020 Cocoatype, LLC. All rights reserved.

import UIKit

class FilmStripCollectionLayoutItem: NSCollectionLayoutItem {
    convenience init(void: Void = ()) {
        self.init(layoutSize: FilmStripCollectionLayoutSize())
    }
}
