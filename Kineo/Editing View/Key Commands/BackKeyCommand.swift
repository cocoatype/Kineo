//  Created by Geoff Pado on 9/4/21.
//  Copyright © 2021 Cocoatype, LLC. All rights reserved.

import UIKit

class BackKeyCommand: EditingKeyCommand {
    convenience override init() {
        self.init(title: NSLocalizedString("EditingViewController.backKeyCommandTitle", comment: "Key command title for going back one page"),
                  action: #selector(EditingViewController.navigateToPage(_:for:)),
                  input: UIKeyCommand.inputLeftArrow,
                  modifierFlags: [])
    }
}
