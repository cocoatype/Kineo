//  Created by Geoff Pado on 9/4/21.
//  Copyright © 2021 Cocoatype, LLC. All rights reserved.

import UIKit

class EditingKeyCommand: UIKeyCommand {
    static let all: [UIKeyCommand] = [
        GalleryKeyCommand(),
        BackKeyCommand(),
        ForwardKeyCommand(),
        ExportKeyCommand(),
        PlayKeyCommand()
    ]
}
