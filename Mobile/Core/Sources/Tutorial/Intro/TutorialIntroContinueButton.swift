//  Created by Geoff Pado on 3/11/20.
//  Copyright © 2020 Cocoatype, LLC. All rights reserved.

import StylePhone
import UIKit

class TutorialIntroContinueButton: UIButton {
    init(style: Style) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = Asset.tutorialIntroAccent.color
        titleLabel?.font = .appFont(forTextStyle: .headline)
        setTitleColor(Asset.tutorialIntroStartButtonTitle.color, for: .normal)
        setTitle(style.title, for: .normal)
        layer.cornerRadius = 8

        addTarget(nil, action: #selector(TutorialEditingViewController.advanceIntro(_:)), for: .primaryActionTriggered)
    }

    enum Style {
        case start, `continue`

        var title: String {
            switch self {
            case .start: return TutorialIntroContinueButton.startTitle
            case .continue: return TutorialIntroContinueButton.continueTitle
            }
        }
    }

    // MARK: Boilerplate

    private static let continueTitle = NSLocalizedString("TutorialIntroContinueButton.continueTitle", comment: "Title for the button to continue the tutorial")
    private static let startTitle = NSLocalizedString("TutorialIntroContinueButton.startTitle", comment: "Title for the button to start the tutorial")

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
