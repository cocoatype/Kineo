//  Created by Geoff Pado on 4/11/22.
//  Copyright © 2022 Cocoatype, LLC. All rights reserved.

import UIKit

class EditingZoomContentView: UIView {
    init() {
        super.init(frame: .zero)
        backgroundColor = .clear
        isOpaque = false
        translatesAutoresizingMaskIntoConstraints = false
    }

    // MARK: Boilerplate

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
