//  Created by Geoff Pado on 2/7/20.
//  Copyright © 2020 Cocoatype, LLC. All rights reserved.

import CoreGraphics

enum PlaybackStyle: CaseIterable {
    case standard, loop, bounce
}

struct ExportSettings {
    let playbackStyle: PlaybackStyle
}
