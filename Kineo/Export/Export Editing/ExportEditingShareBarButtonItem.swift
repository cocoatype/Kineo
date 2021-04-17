//  Created by Geoff Pado on 4/2/21.
//  Copyright © 2021 Cocoatype, LLC. All rights reserved.

import UIKit

class ExportEditingShareBarButtonItem: UIBarButtonItem {
    convenience init(target: Any?) {
        self.init(title: Self.shareTitle, style: .done, target: target, action: #selector(ExportEditingViewController.exportVideo(_:)))
    }

    private static let shareTitle = NSLocalizedString("ExportEditingViewController.shareTitle", comment: "Share button title for export editing")
}
