//  Created by Geoff Pado on 7/19/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import CanvasPhone
import Combine
import DataPhone
import EditingStatePhone
import PencilKit
import UIKit

protocol PlaybackViewDelegate: AnyObject {
    func playbackViewDidFinishPlayback(_ playbackView: PlaybackView)
}

public class PlaybackView: UIView {
    convenience init(statePublisher: EditingStatePublisher) {
        self.init(document: statePublisher.value.document)

        statePublisher.sink { [weak self] state in
            switch state.mode {
            case .playing: self?.startAnimating()
            default: self?.stopAnimating()
            }
        }.store(in: &cancellables)

        statePublisher.sink { [weak self] state in
            self?.document = state.document
        }.store(in: &cancellables)
    }

    public init(document: Document) {
        self.document = document
        self.playbackDocument = Self.transformedDocument(from: document)
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

    private var playbackDocument: Document
    var document: Document {
        didSet(oldDocument) {
            playbackDocument = Self.transformedDocument(from: document)
            if currentIndex > playbackDocument.pages.count { currentIndex = 0 }
            canvasView.drawing = currentDrawing
        }
    }

    private static func transformedDocument(from document: Document) -> Document {
        switch Defaults.exportPlaybackStyle {
        case .standard, .loop: return document
        case .bounce: return DocumentTransformer.bouncedDocument(from: document)
        }
    }

    weak var delegate: PlaybackViewDelegate?

    // MARK: Animation

    private var displayLink: CADisplayLink? {
        didSet(oldValue) {
            oldValue?.invalidate()
        }
    }

    public func startAnimating() {
        isHidden = false
        displayLink?.isPaused = false
    }

    public func stopAnimating() {
        isHidden = true
        displayLink?.isPaused = true
        delegate?.playbackViewDidFinishPlayback(self)
    }

    @objc private func animateNextFrame() {
        let nextIndex = (currentIndex + 1) % playbackDocument.pages.endIndex

        // stop if we are not animating continuously, but the next page would be the first page
        let isRestarting = (nextIndex == playbackDocument.pages.startIndex)
        if isRestarting {
            UIApplication.shared.sendAction(#selector(EditingDrawViewController.restartPlayback(_:)), to: nil, from: self, for: nil)
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

    private var cancellables = Set<AnyCancellable>()
    private let canvasView = CanvasView()
    private var currentIndex = 0

    var canvasCornerRadius: CGFloat {
        get { canvasView.layer.cornerRadius }
        set(newRadius) {
            canvasView.layer.cornerRadius = newRadius
        }
    }

    private var currentPage: Page {
        return playbackDocument.pages[currentIndex]
    }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
