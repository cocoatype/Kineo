//  Created by Geoff Pado on 3/11/20.
//  Copyright © 2020 Cocoatype, LLC. All rights reserved.

import UIKit

class TutorialIntroStartButton: UIButton {
    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .tutorialIntroAccent
        titleLabel?.font = .appFont(forTextStyle: .headline)
        setTitleColor(.tutorialIntroStartButtonTitle, for: .normal)
        setTitle(Self.title, for: .normal)
        layer.cornerRadius = 8
    }

    // MARK: Boilerplate

    private static let title = NSLocalizedString("TutorialIntroStartButton.title", comment: "Title for the button to start the tutorial")

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
