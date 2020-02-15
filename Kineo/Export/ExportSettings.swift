//  Created by Geoff Pado on 2/7/20.
//  Copyright © 2020 Cocoatype, LLC. All rights reserved.

import CoreGraphics
import Data

enum PlaybackStyle: CaseIterable {
    case standard, loop, bounce
}

enum ExportDuration: CaseIterable {
    case threeSeconds, fiveSeconds, tenSeconds

    var minimumFrameCount: Int {
        switch self {
        case .threeSeconds: return Int(Constants.framesPerSecond) * 3
        case .fiveSeconds: return Int(Constants.framesPerSecond) * 5
        case .tenSeconds: return Int(Constants.framesPerSecond) * 10
        }
    }
}

struct ExportSettings {
    let playbackStyle: PlaybackStyle
    let duration: ExportDuration

    var minimumFrameCount: Int { duration.minimumFrameCount }
}
