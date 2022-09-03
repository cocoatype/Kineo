//  Created by Geoff Pado on 2/27/21.
//  Copyright © 2021 Cocoatype, LLC. All rights reserved.

import UIKit

class PageNavigationEvent: UIEvent {
    enum Style {
        case direct(pageIndex: Int)
        case increment, decrement
    }

    let style: Style
    convenience init(pageIndex: Int) {
        self.init(style: .direct(pageIndex: pageIndex))
    }

    init(style: Style) {
        self.style = style
    }
}
