//  Created by Geoff Pado on 4/2/21.
//  Copyright © 2021 Cocoatype, LLC. All rights reserved.

import CoreGraphics
import DataPhone

class ExportEditingShapePicker: ExportEditingPickerControl {
    init() {
        let selectedIndex = Self.shapes.firstIndex(of: Defaults.exportShape) ?? 0
        super.init(images: Self.images, selectedIndex: selectedIndex)
    }

    var selectedShape: ExportShape { Self.shapes[selectedIndex] }

    override var intrinsicContentSize: CGSize { return CGSize(width: 208, height: 46) }

    private static let images = [
        Icons.Export.square,
        Icons.Export.landscape,
        Icons.Export.portrait,
        Icons.Export.squarePlain,
    ]

    private static let shapes = [
        ExportShape.square,
        .landscape,
        .portrait,
        .squarePlain
    ]
}
