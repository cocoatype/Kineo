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
        guard page != self.page || skinsImage != self.skinsImage else { return }
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

    // MARK: Skins Images

    private let skinsImageView = SkinsImageView()
    func showSkinsImage() {
        UIView.animate(withDuration: 0.15) { [weak self] in
            self?.skinsImageView.alpha = 1
        }
    }
    func hideSkinsImage() {
        UIView.animate(withDuration: 0.15) { [weak self] in
            self?.skinsImageView.alpha = 0
        }
    }

    // MARK: PKCanvasViewDelegate

    var toolWasUsed = false
    func canvasViewDidEndUsingTool(_ canvasView: PKCanvasView) {
        toolWasUsed = true
    }

    func canvasViewDrawingDidChange(_ canvasView: PKCanvasView) {
        guard toolWasUsed == true else { return }

        updatePage()
        editingViewController?.drawingViewDidChangePage(self)
        toolWasUsed = false
    }

    func canvasViewDidBeginUsingTool(_ canvasView: PKCanvasView) {
        toolWasUsed = true
    }

    // MARK: Boilerplate

    private let canvasView = CanvasView()

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

private extension UIResponder {
    var editingViewController: EditingViewController? {
        guard let editingViewController = (self as? EditingViewController) else { return next?.editingViewController }
        return editingViewController
    }
}
