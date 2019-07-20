//  Created by Geoff Pado on 7/19/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import UIKit

protocol PlaybackViewDelegate: class {
    func playbackViewDidFinishPlayback(_ playbackView: PlaybackView)
}

class PlaybackView: UIView {
    init(document: Document) {
        self.document = document
        super.init(frame: .zero)

        isHidden = true
        translatesAutoresizingMaskIntoConstraints = false

        canvasView.drawing = currentPage.drawing
        canvasView.isUserInteractionEnabled = false
        addSubview(canvasView)

        NSLayoutConstraint.activate([
            canvasView.widthAnchor.constraint(equalTo: widthAnchor),
            canvasView.heightAnchor.constraint(equalTo: heightAnchor),
            canvasView.centerXAnchor.constraint(equalTo: centerXAnchor),
            canvasView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    var document: Document {
        didSet {
            currentIndex = 0
            canvasView.drawing = currentPage.drawing
        }
    }

    weak var delegate: PlaybackViewDelegate?

    // MARK: Animation

    private var isAnimatingContinuously = false
    private lazy var displayLink: CADisplayLink = {
        let displayLink = CADisplayLink(target: self, selector: #selector(PlaybackView.animateNextFrame))
        displayLink.isPaused = true
        displayLink.preferredFramesPerSecond = PlaybackView.defaultFramesPerSecond
        displayLink.add(to: .main, forMode: .common)
        return displayLink
    }()

    func animate(continuously: Bool = false) {
        isAnimatingContinuously = continuously
        isHidden = false
        displayLink.isPaused = false
    }

    func stopAnimating() {
        isAnimatingContinuously = false
        isHidden = true
        displayLink.isPaused = true
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
        canvasView.drawing = currentPage.drawing
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
