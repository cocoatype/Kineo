//  Created by Geoff Pado on 4/8/22.
//  Copyright © 2022 Cocoatype, LLC. All rights reserved.

import Canvas
import UIKit

class EditingZoomScrollView: UIScrollView {
    init() {
        super.init(frame: .zero)

        contentMode = .center

        contentInsetAdjustmentBehavior = .never
        maximumZoomScale = 4.0
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        translatesAutoresizingMaskIntoConstraints = false

        panGestureRecognizer.minimumNumberOfTouches = 2

        NSLayoutConstraint.activate([
            contentLayoutGuide.widthAnchor.constraint(equalTo: widthAnchor),
            contentLayoutGuide.heightAnchor.constraint(equalTo: heightAnchor)
        ])
    }

    var drawingView: DrawingView? {
        subviews.first(where: { $0 is DrawingView }) as? DrawingView
    }

    // MARK: Boilerplate

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
