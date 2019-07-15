//  Created by Geoff Pado on 7/14/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import PencilKit
import UIKit

class EditingViewController: UIViewController {
    override func loadView() {
        view = EditingView()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if let view = view, let window = view.window {
            PKToolPicker.shared(for: window)?.setVisible(true, forFirstResponder: view)
        }
    }
}
