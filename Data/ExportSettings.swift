//  Created by Geoff Pado on 2/7/20.
//  Copyright © 2020 Cocoatype, LLC. All rights reserved.

import CoreGraphics

public enum PlaybackStyle: CaseIterable {
    case standard, loop, bounce
}

public enum ExportDuration: CaseIterable {
    case threeSeconds, fiveSeconds, tenSeconds

    public var minimumFrameCount: Int {
        switch self {
        case .threeSeconds: return Int(Constants.framesPerSecond) * 3
        case .fiveSeconds: return Int(Constants.framesPerSecond) * 5
        case .tenSeconds: return Int(Constants.framesPerSecond) * 10
        }
    }
}

public struct ExportSettings {
    public init(playbackStyle: PlaybackStyle, duration: ExportDuration) {
        self.playbackStyle = playbackStyle
        self.duration = duration
    }

    public let playbackStyle: PlaybackStyle
    public let duration: ExportDuration

    public var minimumFrameCount: Int { duration.minimumFrameCount }
}
