//  Created by Geoff Pado on 7/14/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import PencilKit

class CanvasView: PKCanvasView {
    init() {
        super.init(frame: .zero)
        backgroundColor = .canvasBackground
        layer.cornerRadius = 8.0
        overrideUserInterfaceStyle = .light
        translatesAutoresizingMaskIntoConstraints = false

        if #available(iOS 14.0, *) {
            drawingPolicy = .anyInput
        }
    }

    // MARK: Boilerplate

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
