//  Created by Geoff Pado on 11/6/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import DataPhone
import UIKit

class GallerySelectionEvent: UIEvent {
    init(document: Document) {
        self.document = document
    }

    let document: Document
}

