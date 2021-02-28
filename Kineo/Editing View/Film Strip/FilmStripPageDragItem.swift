//  Created by Geoff Pado on 2/28/21.
//  Copyright © 2021 Cocoatype, LLC. All rights reserved.

import Data
import UIKit

class FilmStripPageDragItem: UIDragItem {
    init(page: Page) {
        self.page = page
        super.init(itemProvider: FilmStripPageItemProvider())
    }

    let page: Page
}
