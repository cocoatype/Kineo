//  Created by Geoff Pado on 9/5/21.
//  Copyright © 2021 Cocoatype, LLC. All rights reserved.

import UIKit

class DrawingViewGuide: UILayoutGuide {
    override init() {
        super.init()
        identifier = "DrawingViewGuide.identifier"
    }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("\(String(describing: type(of: Self.self))) does not implement init(coder:)")
    }
}
