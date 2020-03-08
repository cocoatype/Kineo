//  Created by Geoff Pado on 3/8/20.
//  Copyright © 2020 Cocoatype, LLC. All rights reserved.

import Foundation

enum TutorialStep {
    case intro
    case drawing
    case adding
    case playing
    case finished
}

class TutorialCoordinator: NSObject {
    static var shouldStartTutorial: Bool {
        return forceShowTutorial
    }

    // MARK: Override

    private static let forceShowTutorialEnvironmentVariable = "FORCE_SHOW_TUTORIAL"
    private static var forceShowTutorial: Bool {
        ProcessInfo.processInfo.environment[forceShowTutorialEnvironmentVariable] != nil
    }
}
