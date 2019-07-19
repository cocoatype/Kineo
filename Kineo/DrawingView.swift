//  Created by Geoff Pado on 7/15/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import PencilKit
import UIKit

class DrawingView: UIControl, PKCanvasViewDelegate {
    init(page: Page) {
        super.init(frame: .zero)

        translatesAutoresizingMaskIntoConstraints = false

        layer.borderWidth = 1
        layer.borderColor = UIColor.opaqueSeparator.cgColor

        canvasView.delegate = self
        canvasView.drawing = page.drawing
        addSubview(canvasView)

        NSLayoutConstraint.activate([
            canvasView.widthAnchor.constraint(equalTo: widthAnchor),
            canvasView.heightAnchor.constraint(equalTo: heightAnchor),
            canvasView.centerXAnchor.constraint(equalTo: centerXAnchor),
            canvasView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    var page: Page {
        return Page(drawing: canvasView.drawing)
    }

    func observe(_ toolPicker: PKToolPicker) {
        toolPicker.setVisible(true, forFirstResponder: self)
        toolPicker.addObserver(canvasView)
    }

    // MARK: PKCanvasViewDelegate

    func canvasViewDrawingDidChange(_ canvasView: PKCanvasView) {
        sendAction(#selector(EditingViewController.drawingViewDidChangePage(_:)), to: nil, for: nil)
    }

    // MARK: Boilerplate

    private let canvasView = CanvasView()

    override var canBecomeFirstResponder: Bool { return true }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
