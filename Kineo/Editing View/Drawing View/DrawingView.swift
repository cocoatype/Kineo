//  Created by Geoff Pado on 7/15/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import Data
import PencilKit
import UIKit

class DrawingView: UIControl, PKCanvasViewDelegate, UIGestureRecognizerDelegate {
    init(page: Page) {
        self.page = page
        super.init(frame: .zero)

        isAccessibilityElement = true
        accessibilityLabel = NSLocalizedString("DrawingView.accessibilityLabel", comment: "Accessibility label for the drawing view")
        accessibilityTraits = [.allowsDirectInteraction]

        translatesAutoresizingMaskIntoConstraints = false

        addSubview(backgroundView)

        canvasView.delegate = self
        canvasView.drawing = page.drawing
        addSubview(canvasView)

        addSubview(skinsImageView)

        NSLayoutConstraint.activate([
            backgroundView.widthAnchor.constraint(equalTo: widthAnchor),
            backgroundView.heightAnchor.constraint(equalTo: heightAnchor),
            backgroundView.centerXAnchor.constraint(equalTo: centerXAnchor),
            backgroundView.centerYAnchor.constraint(equalTo: centerYAnchor),
            canvasView.widthAnchor.constraint(equalTo: widthAnchor),
            canvasView.heightAnchor.constraint(equalTo: heightAnchor),
            canvasView.centerXAnchor.constraint(equalTo: centerXAnchor),
            canvasView.centerYAnchor.constraint(equalTo: centerYAnchor),
            skinsImageView.widthAnchor.constraint(equalTo: widthAnchor),
            skinsImageView.heightAnchor.constraint(equalTo: heightAnchor),
            skinsImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            skinsImageView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])

        addScrollRecognizer()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        updateCanvas()
    }

    func display(page: Page, skinsImage: UIImage?) {
        if skinsImage != self.skinsImage {
            self.skinsImage = skinsImage
        }

        if page != self.page {
            self.page = page
            updateCanvas()
        }
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

    private func handleChange() {
        toolWasUsed = false
        updatePage()
        editingViewController?.drawingViewDidChangePage(self)
    }

    func observe(_ toolPicker: PKToolPicker) {
        toolPicker.colorUserInterfaceStyle = .light
        toolPicker.addObserver(canvasView)
    }

    // MARK: Scroll Recognizer

    private func addScrollRecognizer() {
        guard #available(iOS 13.4, *) else { return }
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handleScroll))
        panGestureRecognizer.allowedTouchTypes = [NSNumber(integerLiteral: UITouch.TouchType.indirectPointer.rawValue)]
        panGestureRecognizer.delegate = self
        panGestureRecognizer.allowedScrollTypesMask = .all
        addGestureRecognizer(panGestureRecognizer)
    }

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        guard #available(iOS 13.4, *) else { return false }
        return touch.type == .indirectPointer
    }

    private var lastTranslation = CGPoint.zero
    @objc func handleScroll(_ sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .began:
            sendAction(#selector(EditingViewController.hideSkinsImage(_:)), to: nil, for: nil)
            fallthrough
        case .changed:
            let lastTranslationIndex = Int(floor(lastTranslation.y / 44))
            let currentTranslation = sender.translation(in: self)
            let currentTranslationIndex = Int(floor(currentTranslation.y / 44))
            lastTranslation = currentTranslation

            guard lastTranslationIndex != currentTranslationIndex else { break }
            if lastTranslationIndex - currentTranslationIndex < 0 {
                sendAction(#selector(EditingViewController.navigateToPage(_:for:)), to: nil, for: PageNavigationEvent(style: .decrement))
            } else {
                sendAction(#selector(EditingViewController.navigateToPage(_:for:)), to: nil, for: PageNavigationEvent(style: .increment))
            }
        case .recognized:
            sendAction(#selector(EditingViewController.showSkinsImage(_:)), to: nil, for: nil)
            sendAction(#selector(editingViewController?.updateFilmStrip(_:)), to: nil, for: nil)
            lastTranslation = .zero
        default: break
        }
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
        let isUndoing = undoManager?.isUndoing ?? false
        let isRedoing = undoManager?.isRedoing ?? false
        guard toolWasUsed || isUndoing || isRedoing else { return }
        handleChange()
    }

    func canvasViewDidBeginUsingTool(_ canvasView: PKCanvasView) {
        toolWasUsed = true
    }

    // MARK: Boilerplate

    private let backgroundView = DrawingBackgroundView()
    private let canvasView = CanvasView()
    private var redoObserver: Any?
    private var undoObserver: Any?

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
