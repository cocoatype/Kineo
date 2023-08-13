//  Created by Geoff Pado on 12/24/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import UIKit

class FilmStripExistingPageImageView: UIImageView {
    init() {
        super.init(frame: .zero)
        contentMode = .scaleAspectFill
        translatesAutoresizingMaskIntoConstraints = false

        layer.cornerRadius = 8.0
        layer.masksToBounds = true
    }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
