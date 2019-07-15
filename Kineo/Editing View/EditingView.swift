//  Created by Geoff Pado on 7/14/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import UIKit

class EditingView: UIView {
    init(page: Page) {
        self.page = page
        super.init(frame: .zero)

        backgroundColor = .systemBackground

        addSubview(drawingView)

        NSLayoutConstraint.activate([
            drawingView.widthAnchor.constraint(equalTo: drawingView.heightAnchor),
            drawingView.widthAnchor.constraint(equalToConstant: 512.0),
            drawingView.centerXAnchor.constraint(equalTo: centerXAnchor),
            drawingView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    // MARK: Boilerplate

    private lazy var drawingView = DrawingView(page: page)
    private let page: Page

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
