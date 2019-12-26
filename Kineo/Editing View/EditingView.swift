//  Created by Geoff Pado on 7/14/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import Data
import PencilKit
import UIKit

class EditingView: UIView, PlaybackViewDelegate {
    init(dataSource: EditingViewDataSource) {
        self.dataSource = dataSource
        super.init(frame: .zero)

        backgroundColor = .appBackground

        addSubview(drawingView)
        addSubview(filmStripView)

        layoutManager.layout(self)

        reloadData()
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        layoutManager.layout(self)
        setupToolPicker()
    }

    func reloadData() {
        page = dataSource.currentPage
        filmStripView.reloadData()
    }

    func setupToolPicker() {
        guard let window = window,
          let toolPicker = PKToolPicker.shared(for: window)
        else { return }

        drawingView.observe(toolPicker)
        _ = drawingView.becomeFirstResponder()

        let alwaysShowToolPicker = traitCollection.horizontalSizeClass != .compact
        toolPicker.setVisible(alwaysShowToolPicker, forFirstResponder: drawingView)
    }

    func toggleToolPicker() {
        guard let window = window,
          let toolPicker = PKToolPicker.shared(for: window)
        else { return }

        toolPicker.setVisible(toolPicker.isVisible.toggled, forFirstResponder: drawingView)
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
        playbackView.delegate = self
        self.playbackView = playbackView
    }

    func playbackViewDidFinishPlayback(_ playbackView: PlaybackView) {
        guard playbackView == self.playbackView else { return }
        playbackView.removeFromSuperview()
        self.playbackView = nil
    }

    // MARK: Boilerplate

    private lazy var drawingView = DrawingView(page: dataSource.currentPage)
    private lazy var filmStripView = FilmStripView(dataSource: dataSource)

    private let dataSource: EditingViewDataSource

    private var layoutManager: EditingViewLayoutManager {
        if traitCollection.horizontalSizeClass == .compact {
            return EditingViewCompactLayoutManager()
        } else {
            return EditingViewRegularLayoutManager()
        }
    }

    private var page: Page {
        get { return drawingView.page }
        set(newPage) { drawingView.page = newPage }
    }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}

extension Bool {
    var toggled: Bool { return self == false }
}
