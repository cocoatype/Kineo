//  Created by Geoff Pado on 7/14/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import PencilKit
import UIKit

class EditingView: UIView, PKCanvasViewDelegate {
    init(page: Page) {
        self.page = page
        super.init(frame: .zero)

        backgroundColor = .systemBackground

        canvasView.delegate = self
        addSubview(canvasView)

        NSLayoutConstraint.activate([
            canvasView.widthAnchor.constraint(equalTo: canvasView.heightAnchor),
            canvasView.widthAnchor.constraint(equalToConstant: 512.0),
            canvasView.centerXAnchor.constraint(equalTo: centerXAnchor),
            canvasView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    // MARK: PKCanvasViewDelegate

    func canvasViewDrawingDidChange(_ canvasView: PKCanvasView) {
        dump(try? JSONEncoder().encode(Page(drawing: canvasView.drawing)).hex)
    }

    // MARK: Boilerplate

    private lazy var canvasView = CanvasView(page: page)
    private let page: Page

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
