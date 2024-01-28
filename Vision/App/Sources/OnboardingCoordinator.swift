//  Created by Geoff Pado on 1/28/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import DataVision
import Foundation
import OnboardingVision

enum OnboardingCoordinator {
    static var onboardingStyle: Style? {
        shouldStartTutorial ? .visionProLaunch : nil
    }

    private static var shouldStartTutorial: Bool {
        return forceShowTutorial || Defaults.seenTutorial == false
    }

    // MARK: Override

    private static let forceShowTutorialEnvironmentVariable = "FORCE_SHOW_TUTORIAL"
    private static var forceShowTutorial: Bool {
        ProcessInfo.processInfo.environment[forceShowTutorialEnvironmentVariable] != nil
    }
}
