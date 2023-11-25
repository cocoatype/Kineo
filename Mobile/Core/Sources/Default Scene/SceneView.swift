//  Created by Geoff Pado on 11/16/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import StylePhone
import UIKit

public class SceneView: UIView {
    public init() {
        super.init(frame: .zero)
        backgroundColor = Asset.background.color
    }

    // MARK: Boilerplate

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
