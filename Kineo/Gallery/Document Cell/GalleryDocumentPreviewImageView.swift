//  Created by Geoff Pado on 11/13/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import UIKit

class GalleryDocumentPreviewImageView: UIImageView {
    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
    }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
