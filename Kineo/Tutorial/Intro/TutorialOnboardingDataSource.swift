//  Created by Geoff Pado on 3/11/22.
//  Copyright © 2022 Cocoatype, LLC. All rights reserved.

import UIKit

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
