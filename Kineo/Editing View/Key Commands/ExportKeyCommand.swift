//  Created by Geoff Pado on 9/4/21.
//  Copyright © 2021 Cocoatype, LLC. All rights reserved.

import UIKit

class ExportKeyCommand: EditingKeyCommand {
    convenience override init() {
        self.init(title: NSLocalizedString("EditingViewController.exportKeyCommandTitle", comment: "Key command title for exporting videos"),
                  action: #selector(EditingDrawViewController.exportVideo),
                  input: "S",
                  modifierFlags: .command)
    }
}
