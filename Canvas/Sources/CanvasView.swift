//  Created by Geoff Pado on 7/14/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import Data
import PencilKit

public class CanvasView: PKCanvasView {
    public init() {
        super.init(frame: .zero)
        backgroundColor = .clear
        isOpaque = false
        layer.cornerRadius = Constants.canvasCornerRadius
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
