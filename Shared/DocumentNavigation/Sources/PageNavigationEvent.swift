//  Created by Geoff Pado on 2/27/21.
//  Copyright © 2021 Cocoatype, LLC. All rights reserved.

import UIKit

public class PageNavigationEvent: UIEvent {
    public enum Style {
        case direct(pageIndex: Int)
        case increment, decrement
    }

    public let style: Style
    public convenience init(pageIndex: Int) {
        self.init(style: .direct(pageIndex: pageIndex))
    }

    public init(style: Style) {
        self.style = style
    }
}
