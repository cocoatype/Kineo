//  Created by Geoff Pado on 7/15/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import Combine
import Data
import EditingState
import PencilKit
import UIKit

public class DrawingView: UIControl, PKCanvasViewDelegate, UIGestureRecognizerDelegate {
    init(statePublisher: EditingStatePublisher) {
        self._page = statePublisher.value.currentPage
        super.init(frame: .zero)

        isAccessibilityElement = true
        accessibilityLabel = NSLocalizedString("DrawingView.accessibilityLabel", comment: "Accessibility label for the drawing view")
        accessibilityTraits = [.allowsDirectInteraction]

        translatesAutoresizingMaskIntoConstraints = false

        addSubview(backgroundView)
        addSubview(backgroundImageView)

        backgroundImageView.backgroundColor = statePublisher.value.canvasBackgroundColor
        canvasView.delegate = self
        canvasView.drawing = page.drawing
        addSubview(canvasView)

        addSubview(skinsImageView)
        addSubview(canvasSnapshotView)

        NSLayoutConstraint.activate([
            backgroundView.widthAnchor.constraint(equalTo: widthAnchor),
            backgroundView.heightAnchor.constraint(equalTo: heightAnchor),
            backgroundView.centerXAnchor.constraint(equalTo: centerXAnchor),
            backgroundView.centerYAnchor.constraint(equalTo: centerYAnchor),
            skinsImageView.widthAnchor.constraint(equalTo: widthAnchor),
            skinsImageView.heightAnchor.constraint(equalTo: heightAnchor),
            skinsImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            skinsImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            backgroundImageView.widthAnchor.constraint(equalTo: widthAnchor),
            backgroundImageView.heightAnchor.constraint(equalTo: heightAnchor),
            backgroundImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            backgroundImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            canvasSnapshotView.widthAnchor.constraint(equalTo: widthAnchor),
            canvasSnapshotView.heightAnchor.constraint(equalTo: heightAnchor),
            canvasSnapshotView.centerXAnchor.constraint(equalTo: centerXAnchor),
            canvasSnapshotView.centerYAnchor.constraint(equalTo: centerYAnchor)
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
            .assign(to: \.backgroundColor, on: backgroundImageView)
            .store(in: &cancellables)

        statePublisher
            .canvasBackgroundImageData()
            .receive(on: RunLoop.main)
            .assign(to: \.backgroundImageData, on: self)
            .store(in: &cancellables)

        statePublisher
            .map { $0.mode.shouldHideSkinsImage }
            .receive(on: RunLoop.main)
            .assign(to: \.hidingSkinsImage, on: self)
            .store(in: &cancellables)

        statePublisher
            .map { $0.mode.shouldHideCanvas }
            .receive(on: RunLoop.main)
            .assign(to: \.hidingCanvas, on: self)
            .store(in: &cancellables)
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        updateCanvas()
    }

    // MARK: Canvas

    public var zoomScale: CGFloat = 1.0 {
        didSet {
            updateCanvas()
        }
    }

    var canvasScale: CGFloat {
        (bounds.width / Constants.canvasSize.width) * zoomScale
    }

    public func startZooming() {
        canvasSnapshotView.setSnapshot(from: page.drawing)
    }

    private func updateCanvas() {
        let transform = CGAffineTransform(scaleX: canvasScale, y: canvasScale)
        canvasView.drawing = page.drawing.transformed(using: transform)

        // make the canvas view huge
        let canvasSize = Constants.canvasSize * canvasScale
        canvasView.frame = CGRect(origin: .zero, size: canvasSize)

        // render the canvas view small
        let inverseScale = 1 / zoomScale
        let scaleTransform = CATransform3DMakeScale(inverseScale, inverseScale, inverseScale)
        canvasView.layer.transform = scaleTransform
        canvasView.layer.position = bounds.center
    }

    private func updatePage() {
        let scale = 1 / canvasScale
        let transform = CGAffineTransform(scaleX: scale, y: scale)
        _page = Page(drawing: canvasView.drawing.transformed(using: transform))
    }

    private func handleChange() {
        toolWasUsed = false
        updatePage()
        sendAction(#selector(DrawingViewActions.drawingViewDidChangePage(_:)), to: nil, for: nil)
    }

    public func observe(_ toolPicker: PKToolPicker) {
        toolPicker.colorUserInterfaceStyle = .light
        toolPicker.addObserver(canvasView)
    }

    public func stopObserving(_ toolPicker: PKToolPicker) {
        toolPicker.removeObserver(canvasView)
    }

    private var hidingCanvas: Bool {
        get { canvasView.isHidden }
        set { canvasView.isHidden = newValue }
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

    private var skinsImage: UIImage? {
        get { return skinsImageView.image }
        set(newImage) {
            guard let newImage = newImage else { return }
            skinsImageView.image = newImage
        }
    }

    // MARK: Background Image

    private let backgroundImageView = BackgroundImageView()
    private var backgroundImageData: Data? {
        didSet(oldBackgroundImageData) {
            guard let data = backgroundImageData else {
                backgroundImageView.image = nil; return
            }

            guard data != oldBackgroundImageData else { return }

            Task.detached(priority: .userInitiated) {
                guard let backgroundImage = UIImage(data: data)
                else { return }

                await MainActor.run { [weak self] in
                    guard self?.backgroundImageData == data else { return }
                    self?.backgroundImageView.image = backgroundImage
                }
            }
        }
    }

    // MARK: PKCanvasViewDelegate

    var toolWasUsed = false

    public func canvasViewDrawingDidChange(_ canvasView: PKCanvasView) {
        let isUndoing = undoManager?.isUndoing ?? false
        let isRedoing = undoManager?.isRedoing ?? false
        guard toolWasUsed || isUndoing || isRedoing else { return }
        handleChange()
    }

    public func canvasViewDidBeginUsingTool(_ canvasView: PKCanvasView) {
        toolWasUsed = true
    }

    public func canvasViewDidFinishRendering(_ canvasView: PKCanvasView) {
        DispatchQueue.main.async {
            self.canvasSnapshotView.clearSnapshot()
        }
    }

    // MARK: Boilerplate

    private let backgroundView = DrawingBackgroundView()
    private let canvasView = CanvasView()
    private let canvasSnapshotView = CanvasSnapshotView()
    private var cancellables = Set<AnyCancellable>()
    private var redoObserver: Any?
    private var undoObserver: Any?

    private var _page: Page
    private(set) public var page: Page {
        get { _page }
        set(newPage) {
            guard _page != newPage else { return }
            _page = newPage
            updateCanvas()
        }
    }

    public override var canBecomeFirstResponder: Bool { return true }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}

private extension EditingState.Mode {
    var shouldHideSkinsImage: Bool {
        switch self {
        case .playing, .scrolling: return true
        default: return false
        }
    }

    var shouldHideCanvas: Bool {
        switch self {
        case .playing: return true
        default: return false
        }
    }
}

@objc public protocol DrawingViewActions {
    func drawingViewDidChangePage(_ sender: DrawingView)
}
