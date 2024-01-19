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

public enum ExportFormat: CaseIterable {
    case video, gif, spatialVideo
}

public enum ExportShape: CaseIterable {
    case square, squarePlain, portrait, landscape

    public var size: CGSize {
        switch self {
        case .square: return CGSize(width: 720, height: 720)
        case .squarePlain: return CGSize(width: 512, height: 512)
        case .portrait: return CGSize(width: 720, height: 1280)
        case .landscape: return CGSize(width: 1280, height: 720)
        }
    }

    public var isPlain: Bool {
        switch self {
        case .squarePlain: return true
        case .square, .portrait, .landscape: return false
        }
    }
}
