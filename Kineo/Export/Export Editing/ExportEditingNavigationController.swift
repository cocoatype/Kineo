//  Created by Geoff Pado on 3/12/21.
//  Copyright © 2021 Cocoatype, LLC. All rights reserved.

import Data
import UIKit

class ExportEditingNavigationController: UINavigationController {
    init(document: Document) {
        super.init(rootViewController: ExportEditingViewController(document: document))
        modalPresentationStyle = .fullScreen
        modalTransitionStyle = .crossDissolve

        navigationBar.standardAppearance = ExportEditingNavigationBarAppearance()
        navigationBar.tintColor = .white
    }

    // MARK: Boilerplate

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
