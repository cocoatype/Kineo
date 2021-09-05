//  Created by Geoff Pado on 9/4/21.
//  Copyright © 2021 Cocoatype, LLC. All rights reserved.

import UIKit

class ForwardKeyCommand: EditingKeyCommand {
    init() {
        super.init(title: NSLocalizedString("EditingViewController.forwardKeyCommandTitle", comment: "Key command title for going forward one page"),
                   action: #selector(EditingViewController.navigateToPage(_:for:)),
                   input: UIKeyCommand.inputRightArrow,
                   modifierFlags: [])
    }
}
