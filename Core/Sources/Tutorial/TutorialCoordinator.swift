//  Created by Geoff Pado on 3/8/20.
//  Copyright © 2020 Cocoatype, LLC. All rights reserved.

import DataPhone
import UIKit

enum TutorialStep {
    case intro
    case drawing
    case adding
    case playing
    case finished
}

public class TutorialCoordinator: NSObject {
    public static var shouldStartTutorial: Bool {
        return forceShowTutorial || Defaults.seenTutorial == false
    }

    // MARK: Override

    private static let forceShowTutorialEnvironmentVariable = "FORCE_SHOW_TUTORIAL"
    private static var forceShowTutorial: Bool {
        ProcessInfo.processInfo.environment[forceShowTutorialEnvironmentVariable] != nil
    }
}

extension Array {
    public mutating func partitions(by belongsInSecondPartition: (Element) throws -> Bool) rethrows -> ([Element], [Element]) {
        var copy = self
        let index: Int = try copy.partition(by: belongsInSecondPartition)
        return ([Element](copy[0..<index]), [Element](copy[index..<copy.endIndex]))
    }
}
