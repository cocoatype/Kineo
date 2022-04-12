//  Created by Geoff Pado on 7/15/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import Combine
import Data
import PencilKit
import UIKit

class DrawingView: UIControl, PKCanvasViewDelegate, UIGestureRecognizerDelegate {
    init(statePublisher: EditingStatePublisher) {
        self._page = statePublisher.value.currentPage
        super.init(frame: .zero)

        isAccessibilityElement = true
        accessibilityLabel = NSLocalizedString("DrawingView.accessibilityLabel", comment: "Accessibility label for the drawing view")
        accessibilityTraits = [.allowsDirectInteraction]

        translatesAutoresizingMaskIntoConstraints = false

        addSubview(backgroundView)

        canvasView.backgroundColor = statePublisher.value.canvasBackgroundColor
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

        addGestureRecognizer(DrawingViewScrollRecognizer())

        statePublisher
            .map { $0.currentPage }
            .assign(to: \.page, on: self)
            .store(in: &cancellables)

        statePublisher
            .skinsImage()
            .receive(on: RunLoop.main)
            .assign(to: \.skinsImage, on: self)
            .store(in: &cancellables)

        statePublisher
            .canvasBackgroundColor()
            .receive(on: RunLoop.main)
            .assign(to: \.backgroundColor, on: canvasView)
            .store(in: &cancellables)

        statePublisher
            .map { $0.mode == .scrolling }
            .receive(on: RunLoop.main)
            .assign(to: \.hidingSkinsImage, on: self)
            .store(in: &cancellables)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        updateCanvas()
    }

    private func updateCanvas() {
        updateDrawingScale()
        updateToolScale()
    }

    private func updateDrawingScale() {
        let scale = bounds.width / Constants.canvasSize.width
        let transform = CGAffineTransform(scaleX: scale, y: scale)
        canvasView.drawing = page.drawing.transformed(using: transform)
    }

    private func updateToolScale() {
//        guard var tool = canvasView.tool as? PKInkingTool else { return }
//        let scale = frame.width / Constants.canvasSize.width
//        print("scale: \(scale)")
//        print("current width: \(tool.width)")
//        let defaultWidth = tool.inkType.defaultWidth
//        print("range: \(tool.inkType.validWidthRange)")
//        print("default width: \(defaultWidth)")
//        let scaledWidth = (1 / scale) * defaultWidth
//        print("scaled width: \(scaledWidth)")
//        tool.width = scaledWidth
//        canvasView.tool = tool
//        print("------------")
    }

    private func updatePage() {
        let scale = Constants.canvasSize.width / bounds.width
        let transform = CGAffineTransform(scaleX: scale, y: scale)
        _page = Page(drawing: canvasView.drawing.transformed(using: transform))
    }

    private func handleChange() {
        toolWasUsed = false
        updatePage()
        sendAction(#selector(EditingViewController.drawingViewDidChangePage(_:)), to: nil, for: nil)
    }

    func observe(_ toolPicker: PKToolPicker) {
        toolPicker.colorUserInterfaceStyle = .light
        toolPicker.addObserver(canvasView)
    }

    func stopObserving(_ toolPicker: PKToolPicker) {
        toolPicker.removeObserver(canvasView)
    }

    // MARK: Skins Images

    private let skinsImageView = SkinsImageView()
    private var hidingSkinsImage = false {
        didSet {
            UIView.animate(withDuration: 0.15) { [weak self] in
                guard let drawingView = self else { return }
                drawingView.skinsImageView.alpha = (drawingView.hidingSkinsImage ? 0 : 1)
            }
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
    private var cancellables = Set<AnyCancellable>()
    private var redoObserver: Any?
    private var undoObserver: Any?

    private var _page: Page
    private(set) var page: Page {
        get { _page }
        set(newPage) {
            guard _page != newPage else { return }
            _page = newPage
            updateCanvas()
        }
    }

    private var skinsImage: UIImage {
        get { return skinsImageView.image ?? UIImage.emptyImage(withSize: Constants.canvasSize) }
        set(newImage) { skinsImageView.image = newImage }
    }

    override var canBecomeFirstResponder: Bool { return true }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
