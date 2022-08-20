//  Created by Geoff Pado on 8/19/22.
//  Copyright © 2022 Cocoatype, LLC. All rights reserved.

import Data
import UIKit

class GalleryDocumentBackgroundView: UIImageView {
    init(document: Document) {
        super.init(frame: .zero)
        backgroundColor = document.canvasBackgroundColor
        contentMode = .scaleAspectFill
        translatesAutoresizingMaskIntoConstraints = false

        if let backgroundData = document.backgroundImageData, let backgroundImage = UIImage(data: backgroundData) {
            image = backgroundImage
        }
    }

    // MARK: Boilerplate

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
