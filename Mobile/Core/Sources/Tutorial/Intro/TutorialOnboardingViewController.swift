//  Created by Geoff Pado on 3/8/20.
//  Copyright © 2020 Cocoatype, LLC. All rights reserved.

import DataPhone
import UIKit
import SwiftUI

class TutorialOnboardingViewController: UIPageViewController {
    init() {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
        dataSource = tutorialDataSource
        modalPresentationStyle = .formSheet
        preferredContentSize = CGSize(width: 425, height: 550)

        setViewControllers([TutorialOnboardingIntroPageViewController()], direction: .forward, animated: false)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Defaults.seenTutorial = true
    }

    // MARK: Page Controls

    var hasNextPage: Bool {
        guard let current = viewControllers?.first else { return false }
        return tutorialDataSource.pageViewController(self, viewControllerAfter: current) != nil
    }

    func advance() {
        guard let current = viewControllers?.first, let next = tutorialDataSource.pageViewController(self, viewControllerAfter: current) else { return }
        setViewControllers([next], direction: .forward, animated: true)
    }

    // MARK: Boilerplate

    private let tutorialDataSource = TutorialOnboardingDataSource()

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
