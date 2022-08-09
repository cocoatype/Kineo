//  Created by Geoff Pado on 8/8/22.
//  Copyright © 2022 Cocoatype, LLC. All rights reserved.

import UIKit

class EditingPlayViewController: UIViewController {
    init() {
        super.init(nibName: nil, bundle: nil)
    }

    override func loadView() {
        view = EditingPlayView()
    }

    // MARK: Boilerplate

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
