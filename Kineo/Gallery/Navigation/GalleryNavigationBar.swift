//  Created by Geoff Pado on 2/2/20.
//  Copyright © 2020 Cocoatype, LLC. All rights reserved.

import UIKit

class GalleryNavigationBar: UINavigationBar {
    public override init(frame: CGRect) {
        super.init(frame: frame)
        prefersLargeTitles = true
        standardAppearance = GalleryNavigationBarAppearance()
    }

    var horizontalInset: CGFloat {
        get { return layoutMargins.left }
        set(newInset) {
            layoutMargins.left = newInset
            layoutMargins.right = newInset
        }
    }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
