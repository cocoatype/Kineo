//  Created by Geoff Pado on 11/15/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import Core
import UIKit

class GalleryNewDocumentImageView: UIImageView {
    init() {
        super.init(frame: .zero)
        backgroundColor = .clear
        image = Icons.newDocument
        tintColor = .newCellTint
        translatesAutoresizingMaskIntoConstraints = false
    }

    // MARK: Boilerplate

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
