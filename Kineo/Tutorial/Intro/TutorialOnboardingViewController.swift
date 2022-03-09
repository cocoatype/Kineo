//  Created by Geoff Pado on 3/8/20.
//  Copyright © 2020 Cocoatype, LLC. All rights reserved.

import Data
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

    // MARK: Boilerplate

    private let tutorialDataSource = TutorialOnboardingDataSource()

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}

class TutorialOnboardingDataSource: NSObject, UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if viewController is TutorialOnboardingSharePageViewController {
            return TutorialOnboardingPlayPageViewController()
        } else if viewController is TutorialOnboardingPlayPageViewController {
            return TutorialOnboardingDrawPageViewController()
        } else if viewController is TutorialOnboardingDrawPageViewController {
            return TutorialOnboardingIntroPageViewController()
        } else {
            return nil
        }
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if viewController is TutorialOnboardingIntroPageViewController {
            return TutorialOnboardingDrawPageViewController()
        } else if viewController is TutorialOnboardingDrawPageViewController {
            return TutorialOnboardingPlayPageViewController()
        } else if viewController is TutorialOnboardingPlayPageViewController {
            return TutorialOnboardingSharePageViewController()
        } else {
            return nil
        }
    }
}
