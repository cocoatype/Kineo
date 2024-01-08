//  Created by Geoff Pado on 3/11/20.
//  Copyright © 2020 Cocoatype, LLC. All rights reserved.

import StylePhone
import UIKit

class TutorialIntroDismissButton: UIButton {
    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = Asset.sidebarButtonBackground.color
        titleLabel?.font = .appFont(forTextStyle: .body)
        setTitleColor(Asset.tutorialIntroDismissButtonTitle.color, for: .normal)
        setTitle(Self.title, for: .normal)
        layer.cornerRadius = 8

        addTarget(nil, action: #selector(TutorialEditingViewController.dismissIntro(_:)), for: .primaryActionTriggered)
    }

    // MARK: Boilerplate

    private static let title = NSLocalizedString("TutorialIntroDismissButton.title", comment: "Title for the button to skip the tutorial")

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
