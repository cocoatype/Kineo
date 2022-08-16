//  Created by Geoff Pado on 8/8/22.
//  Copyright © 2022 Cocoatype, LLC. All rights reserved.

import Data
import UIKit

class EditingPlayViewController: UIViewController {
    init(document: Document) {
        self.document = document
        super.init(nibName: nil, bundle: nil)
    }

    override func loadView() {
        view = EditingPlayView(document: document)
    }

    // MARK: Boilerplate

    private let document: Document

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
