//  Created by Geoff Pado on 7/14/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import PencilKit
import UIKit

class EditingView: UIView, PlaybackViewDelegate {
    init(page: Page) {
        self.page = page
        super.init(frame: .zero)

        backgroundColor = .appBackground

        addSubview(drawingView)

        NSLayoutConstraint.activate([
            drawingView.widthAnchor.constraint(equalTo: drawingView.heightAnchor),
            drawingView.widthAnchor.constraint(equalToConstant: 512.0),
            drawingView.centerXAnchor.constraint(equalTo: centerXAnchor),
            drawingView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    func setupToolPicker() {
        guard let window = window,
            let toolPicker = PKToolPicker.shared(for: window)
            else { return }

        drawingView.observe(toolPicker)
        _ = drawingView.becomeFirstResponder()
    }

    // MARK: Playback

    private var playbackView: PlaybackView?

    func play(_ document: Document, continuously: Bool = false) {
        let playbackView: PlaybackView
        if let existingPlaybackView = self.playbackView {
            existingPlaybackView.document = document
            playbackView = existingPlaybackView
        } else {
            playbackView = PlaybackView(document: document)

            addSubview(playbackView)
            NSLayoutConstraint.activate([
                playbackView.widthAnchor.constraint(equalTo: drawingView.widthAnchor),
                playbackView.heightAnchor.constraint(equalTo: drawingView.heightAnchor),
                playbackView.centerXAnchor.constraint(equalTo: drawingView.centerXAnchor),
                playbackView.centerYAnchor.constraint(equalTo: drawingView.centerYAnchor)
            ])
        }

        playbackView.animate(continuously: continuously)
        self.playbackView = playbackView
    }

    func playbackViewDidFinishPlayback(_ playbackView: PlaybackView) {
        guard playbackView == self.playbackView else { return }
        playbackView.removeFromSuperview()
        self.playbackView = nil
    }

    // MARK: Boilerplate

    private lazy var drawingView = DrawingView(page: page)

    var page: Page {
        didSet {
            drawingView.page = page
        }
    }
    var skinsImage: UIImage? {
        get { return drawingView.skinsImage }
        set(newImage) {
            drawingView.skinsImage = newImage
        }
    }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
