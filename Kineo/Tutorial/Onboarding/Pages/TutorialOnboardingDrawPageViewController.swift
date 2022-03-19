//  Created by Geoff Pado on 3/8/22.
//  Copyright © 2022 Cocoatype, LLC. All rights reserved.

import UIKit

class TutorialOnboardingDrawPageViewController: UIViewController {
    init() {
        super.init(nibName: nil, bundle: nil)
    }

    override func loadView() {
        view = TutorialOnboardingPageView(header: NSLocalizedString("TutorialOnboardingDrawPageView.headerText", comment: "Text for the header of the tutorial draw page"),
                                          body: NSLocalizedString("TutorialOnboardingDrawPageView.bodyText", comment: "Text for the body of the tutorial draw page"),
                                          animationName: "OnboardingDraw")
    }

    // MARK: Boilerplate

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
