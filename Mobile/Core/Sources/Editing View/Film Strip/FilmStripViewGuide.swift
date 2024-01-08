//  Created by Geoff Pado on 10/14/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import UIKit

class FilmStripViewGuide: UILayoutGuide {
    override init() {
        super.init()
        identifier = "FilmStripViewGuide.identifier"
    }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("\(String(describing: type(of: Self.self))) does not implement init(coder:)")
    }
}
