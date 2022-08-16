//  Created by Geoff Pado on 9/4/21.
//  Copyright © 2021 Cocoatype, LLC. All rights reserved.

import UIKit

class PlayKeyCommand: EditingKeyCommand {
    convenience override init() {
        self.init(title: NSLocalizedString("EditingViewController.playKeyCommandTitle", comment: "Key command title for playing an animation"),
                  action: #selector(EditingDrawViewController.play),
                  input: " ",
                  modifierFlags: [])
    }
}
