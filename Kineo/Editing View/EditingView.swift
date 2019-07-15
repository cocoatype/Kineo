//  Created by Geoff Pado on 7/14/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import UIKit

class EditingView: UIView {
    init() {
        super.init(frame: .zero)
        backgroundColor = .systemBackground

        addSubview(canvasView)

        NSLayoutConstraint.activate([
            canvasView.widthAnchor.constraint(equalTo: canvasView.heightAnchor),
            canvasView.widthAnchor.constraint(equalToConstant: 512.0),
            canvasView.centerXAnchor.constraint(equalTo: centerXAnchor),
            canvasView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    // MARK: Boilerplate

    private let canvasView = CanvasView()

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
