//  Created by Geoff Pado on 10/8/21.
//  Copyright © 2021 Cocoatype, LLC. All rights reserved.

import UIKit

class FilmStripMoveEvent: UIEvent {
    let source: Int
    let destination: Int

    init(source: IndexPath, destination: IndexPath) {
        self.source = source.item
        self.destination = destination.item
    }
}
