//  Created by Geoff Pado on 7/14/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import PencilKit
import UIKit

class EditingView: UIView {
    init(page: Page) {
        self.page = page
        super.init(frame: .zero)

        backgroundColor = .systemBackground

        addSubview(drawingView)
        addSubview(transportControlsView)

        NSLayoutConstraint.activate([
            drawingView.widthAnchor.constraint(equalTo: drawingView.heightAnchor),
            drawingView.widthAnchor.constraint(equalToConstant: 512.0),
            drawingView.centerXAnchor.constraint(equalTo: centerXAnchor),
            drawingView.centerYAnchor.constraint(equalTo: centerYAnchor),
            transportControlsView.centerXAnchor.constraint(equalTo: drawingView.centerXAnchor),
            transportControlsView.topAnchor.constraint(equalTo: drawingView.bottomAnchor, constant: 20),
            transportControlsView.widthAnchor.constraint(equalTo: drawingView.widthAnchor),
            transportControlsView.heightAnchor.constraint(equalToConstant: 60.0)
        ])
    }

    func setupToolPicker() {
        guard let window = window,
            let toolPicker = PKToolPicker.shared(for: window)
            else { return }

        drawingView.observe(toolPicker)
        _ = drawingView.becomeFirstResponder()
    }

    // MARK: Boilerplate

    private lazy var drawingView = DrawingView(page: page)
    private let transportControlsView = TransportControlsView()
    private let page: Page

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
