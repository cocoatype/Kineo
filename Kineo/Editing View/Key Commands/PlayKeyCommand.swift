//  Created by Geoff Pado on 9/4/21.
//  Copyright © 2021 Cocoatype, LLC. All rights reserved.

import UIKit

class PlayKeyCommand: EditingKeyCommand {
    init() {
        super.init(title: NSLocalizedString("EditingViewController.playKeyCommandTitle", comment: "Key command title for playing an animation"),
                   action: #selector(EditingViewController.play),
                   input: " ",
                   modifierFlags: [])
    }
}
