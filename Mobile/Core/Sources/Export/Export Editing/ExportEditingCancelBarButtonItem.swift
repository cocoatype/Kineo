//  Created by Geoff Pado on 4/2/21.
//  Copyright © 2021 Cocoatype, LLC. All rights reserved.

import UIKit

class ExportEditingCancelBarButtonItem: UIBarButtonItem {
    convenience init(target: Any?) {
        self.init(barButtonSystemItem: .cancel, target: target, action: #selector(ExportEditingViewController.dismissSelf))
    }
}
