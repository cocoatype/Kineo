//  Created by Geoff Pado on 2/27/21.
//  Copyright © 2021 Cocoatype, LLC. All rights reserved.

import Data
import UIKit

class FilmStripCollectionViewDelegate: NSObject {}

class FilmStripPageDragItem: UIDragItem {
    init(page: Page) {
        self.page = page
        super.init(itemProvider: FilmStripPageItemProvider())
    }

    let page: Page
}

class FilmStripPageItemProvider: NSItemProvider {
    override init() {
        super.init()
    }
}
