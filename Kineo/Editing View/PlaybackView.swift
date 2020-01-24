//  Created by Geoff Pado on 7/19/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import Data
import PencilKit
import UIKit

protocol PlaybackViewDelegate: class {
    func playbackViewDidFinishPlayback(_ playbackView: PlaybackView)
}

class PlaybackView: UIView {
    init(document: Document) {
        self.document = document
        super.init(frame: .zero)

        isHidden = true
        overrideUserInterfaceStyle = .light
        translatesAutoresizingMaskIntoConstraints = false

        canvasView.drawing = currentDrawing
        canvasView.isUserInteractionEnabled = false
        addSubview(canvasView)

        NSLayoutConstraint.activate([
            canvasView.widthAnchor.constraint(equalTo: widthAnchor),
            canvasView.heightAnchor.constraint(equalTo: heightAnchor),
            canvasView.centerXAnchor.constraint(equalTo: centerXAnchor),
            canvasView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])

        let displayLink = CADisplayLink(target: self, selector: #selector(PlaybackView.animateNextFrame))
        displayLink.isPaused = true
        displayLink.preferredFramesPerSecond = PlaybackView.defaultFramesPerSecond
        displayLink.add(to: .main, forMode: .common)
        self.displayLink = displayLink
    }

    var document: Document {
        didSet(oldDocument) {
            guard document != oldDocument else { return }
            currentIndex = 0
            canvasView.drawing = currentDrawing
        }
    }

    weak var delegate: PlaybackViewDelegate?

    // MARK: Animation

    private var isAnimatingContinuously = false
    private var displayLink: CADisplayLink? {
        didSet(oldValue) {
            oldValue?.invalidate()
        }
    }

    func animate(continuously: Bool = false) {
        isAnimatingContinuously = continuously
        isHidden = false
        displayLink?.isPaused = false
    }

    func stopAnimating() {
        isAnimatingContinuously = false
        isHidden = true
        displayLink?.isPaused = true
        delegate?.playbackViewDidFinishPlayback(self)
    }

    @objc private func animateNextFrame() {
        let nextIndex = (currentIndex + 1) % document.pages.endIndex

        // stop if we are not animating continuously, but the next page would be the first page
        let shouldStop = (nextIndex == document.pages.startIndex && isAnimatingContinuously == false)
        guard shouldStop == false else {
            stopAnimating()
            return
        }

        currentIndex = nextIndex
        canvasView.drawing = currentDrawing
    }

    private var currentDrawing: PKDrawing {
        let scaleFactor = bounds.width / Constants.canvasSize.width
        let transform = CGAffineTransform(scaleX: scaleFactor, y: scaleFactor)
        return currentPage.drawing.transformed(using: transform)
    }

    // MARK: Boilerplate

    private static let defaultFramesPerSecond = 12

    private let canvasView = CanvasView()
    private var currentIndex = 0

    private var currentPage: Page {
        return document.pages[currentIndex]
    }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
