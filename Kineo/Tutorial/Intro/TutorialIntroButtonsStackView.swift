//  Created by Geoff Pado on 3/11/20.
//  Copyright © 2020 Cocoatype, LLC. All rights reserved.

import UIKit

class TutorialIntroButtonsStackView: UIStackView {
    init() {
        super.init(frame: .zero)
        axis = .horizontal
        distribution = .fillProportionally
        spacing = 11
        translatesAutoresizingMaskIntoConstraints = false
        setContentCompressionResistancePriority(.required, for: .horizontal)

        addArrangedSubview(dismissButton)
        addArrangedSubview(startButton)
    }

    // MARK: Boilerplate

    private let dismissButton = TutorialIntroDismissButton()
    private let startButton = TutorialIntroStartButton()

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
