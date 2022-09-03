//  Created by Geoff Pado on 3/8/22.
//  Copyright © 2022 Cocoatype, LLC. All rights reserved.

import UIKit

class TutorialOnboardingIntroPageViewController: UIViewController {
    init() {
        super.init(nibName: nil, bundle: nil)
    }

    override func loadView() {
        view = TutorialIntroPageView()
    }

    // MARK: Boilerplate

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
