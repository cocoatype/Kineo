//  Created by Geoff Pado on 8/8/22.
//  Copyright © 2022 Cocoatype, LLC. All rights reserved.

import Data
import UIKit

class EditingViewController: UIViewController {
    let document: Document
    init(document: Document) {
        self.document = document
        super.init(nibName: nil, bundle: nil)

        embed(EditingDrawViewController(document: document))
    }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }

    // MARK: Drawing

    var drawView: EditingDrawView? {
        (children.first as? EditingDrawViewController)?.view as? EditingDrawView
    }

    // MARK: Display Mode

    @objc func setDrawDisplayMode(_ sender: Any) {}
    @objc func setPlayDisplayMode(_ sender: Any) {}
    @objc func setFramesDisplayMode(_ sender: Any) {}
    @objc func setCompareDisplayMode(_ sender: Any) {}
}
