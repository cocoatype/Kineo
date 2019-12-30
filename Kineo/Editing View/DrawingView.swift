//  Created by Geoff Pado on 7/15/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import Data
import PencilKit
import UIKit

class DrawingView: UIControl, PKCanvasViewDelegate {
    init(page: Page) {
        self.page = page
        super.init(frame: .zero)

        overrideUserInterfaceStyle = .light
        translatesAutoresizingMaskIntoConstraints = false

        layer.shadowColor = UIColor.appShadow.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowOpacity = 1
        layer.shadowRadius = 3
        layer.cornerRadius = 8

        canvasView.delegate = self
        canvasView.drawing = page.drawing
        addSubview(canvasView)

        addSubview(skinsImageView)

        NSLayoutConstraint.activate([
            canvasView.widthAnchor.constraint(equalTo: widthAnchor),
            canvasView.heightAnchor.constraint(equalTo: heightAnchor),
            canvasView.centerXAnchor.constraint(equalTo: centerXAnchor),
            canvasView.centerYAnchor.constraint(equalTo: centerYAnchor),
            skinsImageView.widthAnchor.constraint(equalTo: widthAnchor),
            skinsImageView.heightAnchor.constraint(equalTo: heightAnchor),
            skinsImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            skinsImageView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        updateCanvas()
    }

    func display(page: Page, skinsImage: UIImage?) {
        guard page != self.page else { return }
        self.page = page
        self.skinsImage = skinsImage
        updateCanvas()
    }

    private func updateCanvas() {
        let scale = bounds.width / Constants.canvasSize.width
        let transform = CGAffineTransform(scaleX: scale, y: scale)
        canvasView.drawing = page.drawing.transformed(using: transform)
    }

    private func updatePage() {
        let scale = Constants.canvasSize.width / bounds.width
        let transform = CGAffineTransform(scaleX: scale, y: scale)
        page = Page(drawing: canvasView.drawing.transformed(using: transform))
    }

    func observe(_ toolPicker: PKToolPicker) {
        toolPicker.colorUserInterfaceStyle = .light
        toolPicker.setVisible(true, forFirstResponder: self)
        toolPicker.addObserver(canvasView)
    }

    // MARK: PKCanvasViewDelegate

    func canvasViewDidEndUsingTool(_ canvasView: PKCanvasView) {
        updatePage()
        sendAction(#selector(EditingViewController.drawingViewDidChangePage(_:)), to: nil, for: nil)
    }

    // MARK: Boilerplate

    private let canvasView = CanvasView()
    private let skinsImageView = SkinsImageView()

    private(set) var page: Page

    private var skinsImage: UIImage? {
        get { return skinsImageView.image }
        set(newImage) { skinsImageView.image = newImage }
    }

    override var canBecomeFirstResponder: Bool { return true }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
