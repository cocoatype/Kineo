//  Created by Geoff Pado on 8/8/22.
//  Copyright © 2022 Cocoatype, LLC. All rights reserved.

import UIKit

class EditingPlayView: UIView {
    init() {
        super.init(frame: .zero)
        backgroundColor = .appBackground

        addSubview(displayModeButton)

        NSLayoutConstraint.activate([
            displayModeButton.topAnchor.constraint(equalTo: topAnchor, constant: 11),
            displayModeButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 11)
        ])
    }

    // MARK: Boilerplate

    private let displayModeButton = DisplayModeButton(mode: .play)

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
