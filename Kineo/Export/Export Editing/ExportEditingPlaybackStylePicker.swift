//  Created by Geoff Pado on 4/2/21.
//  Copyright © 2021 Cocoatype, LLC. All rights reserved.

import CoreGraphics
import Data

class ExportEditingPlaybackStylePicker: ExportEditingPickerControl {
    init() {
        let selectedIndex = Self.styles.firstIndex(of: Defaults.exportPlaybackStyle) ?? 0
        super.init(images: Self.images, selectedIndex: selectedIndex)
    }

    var selectedStyle: PlaybackStyle { Self.styles[selectedIndex] }

    override var intrinsicContentSize: CGSize { return CGSize(width: 102, height: 46) }

    private static let images = [
        Icons.Export.loop,
        Icons.Export.bounce
    ]

    private static let styles = [
        PlaybackStyle.loop,
        .bounce
    ]
}
