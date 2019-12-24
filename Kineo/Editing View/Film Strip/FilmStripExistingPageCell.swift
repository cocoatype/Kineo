//  Created by Geoff Pado on 12/24/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import UIKit

class FilmStripExistingPageCell: UICollectionViewCell {
    static let identifier = "FilmStripExistingPageCell.identifier"

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .canvasBackground
        layer.cornerRadius = 8
    }

    // MARK: Boilerplate

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
