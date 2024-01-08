//  Created by Geoff Pado on 4/2/21.
//  Copyright © 2021 Cocoatype, LLC. All rights reserved.

import UIKit

class ExportEditingSettingsBarButtonItem: UIBarButtonItem {
    convenience init(target: Any?) {
        self.init(image: UIImage(systemName: "ellipsis.circle.fill"), style: .plain, target: target, action: #selector(ExportEditingViewController.displaySettings(_:)))
    }
}
