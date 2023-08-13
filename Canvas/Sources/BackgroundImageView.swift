//  Created by Geoff Pado on 5/20/22.
//  Copyright © 2022 Cocoatype, LLC. All rights reserved.

import Data
import UIKit

public class BackgroundImageView: UIImageView {
    public init() {
        super.init(frame: .zero)
        contentMode = .scaleAspectFill
        translatesAutoresizingMaskIntoConstraints = false

        layer.cornerRadius = Constants.canvasCornerRadius
        layer.masksToBounds = true
    }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
