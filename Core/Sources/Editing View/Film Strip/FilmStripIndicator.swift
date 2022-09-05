//  Created by Geoff Pado on 12/24/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import UIKit

class FilmStripIndicator: UIView {
    init() {
        super.init(frame: .zero)
        backgroundColor = .filmStripIndicator
        layer.cornerRadius = 1
        translatesAutoresizingMaskIntoConstraints = false
    }

    override var intrinsicContentSize: CGSize {
        switch traitCollection.horizontalSizeClass {
        case .compact: return CGSize(width: 28, height: 2)
        default: return CGSize(width: 2, height: 28)
        }
    }

    // MARK: Boilerplate

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
