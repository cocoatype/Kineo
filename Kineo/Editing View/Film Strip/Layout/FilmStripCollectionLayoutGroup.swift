//  Created by Geoff Pado on 1/23/20.
//  Copyright © 2020 Cocoatype, LLC. All rights reserved.

import UIKit

class FilmStripCollectionLayoutGroup: NSCollectionLayoutGroup {
    class func standardGroup() -> FilmStripCollectionLayoutGroup {
        let group = FilmStripCollectionLayoutGroup.horizontal(layoutSize: FilmStripCollectionLayoutSize(), subitem: FilmStripCollectionLayoutItem(), count: 1)
        return group
    }
}
