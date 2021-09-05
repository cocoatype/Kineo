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

    init(title: String, action: Selector, input: String, modifierFlags: UIKeyModifierFlags) {
        self._action = action
        self._input = input
        self._modifierFlags = modifierFlags
        super.init()
        self.title = title
    }

    private let _action: Selector?
    override var action: Selector? { _action }

    private let _input: String
    override var input: String? { _input }

    private let _modifierFlags: UIKeyModifierFlags
    override var modifierFlags: UIKeyModifierFlags { _modifierFlags }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("\(String(describing: type(of: Self.self))) does not implement init(coder:)")
    }
}
