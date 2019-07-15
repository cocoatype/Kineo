//  Created by Geoff Pado on 7/14/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import PencilKit

class CanvasView: PKCanvasView {
    init(page: Page) {
        super.init(frame: .zero)

        drawing = page.drawing

        tool = PKInkingTool(.pen, color: .systemRed, width: 5)
        translatesAutoresizingMaskIntoConstraints = false

        layer.borderWidth = 1
        layer.borderColor = UIColor.opaqueSeparator.cgColor
    }

    // MARK: Boilerplate

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
