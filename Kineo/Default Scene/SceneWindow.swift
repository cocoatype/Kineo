//  Created by Geoff Pado on 7/14/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import Data
import UIKit

class SceneWindow: UIWindow {
    init(windowScene: UIWindowScene, document: Document?) {
        super.init(windowScene: windowScene)
        rootViewController = SceneViewController(document: document)
    }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
