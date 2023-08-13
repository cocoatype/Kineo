//  Created by Geoff Pado on 8/8/22.
//  Copyright © 2022 Cocoatype, LLC. All rights reserved.

import Foundation

enum FeatureFlag {
    static var displayMode: Bool {
        ProcessInfo.processInfo.environment["FF_DISPLAY_MODE"] != nil
    }
}
