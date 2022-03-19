//  Created by Geoff Pado on 9/29/21.
//  Copyright © 2021 Cocoatype, LLC. All rights reserved.

import Data
import PencilKit
import UIKit

class RegularEditingView: EditingView {
    var drawingFrame: CGRect { drawingView.frame }
    var drawingView: DrawingView { drawingViewController.drawingView }
    let drawingViewGuide = DrawingViewGuide()

    required init(statePublisher: EditingStatePublisher, drawingViewController: DrawingViewController) {
        self.drawingViewController = drawingViewController
        self.statePublisher = statePublisher
        self.toolPicker = EditingToolPicker(statePublisher: statePublisher, drawingView: drawingViewController.drawingView)
        super.init(frame: .zero)

        backgroundColor = .appBackground

        addLayoutGuide(drawingViewGuide)

        #if CLIP
        [filmStripView, playButton, exportButton, playbackView].forEach(self.addSubview(_:))
        #else
        [filmStripView, playButton, galleryButton, exportButton, playbackView].forEach(self.addSubview(_:))
        #endif

        NSLayoutConstraint.activate([
            drawingViewGuide.widthAnchor.constraint(equalTo: drawingViewGuide.heightAnchor),
            drawingViewGuide.widthAnchor.constraint(equalToConstant: 512.0),
            drawingViewGuide.centerXAnchor.constraint(equalTo: centerXAnchor),
            drawingViewGuide.centerYAnchor.constraint(equalTo: centerYAnchor),
            filmStripView.bottomAnchor.constraint(equalTo: playButton.topAnchor, constant: -11),
            filmStripView.widthAnchor.constraint(equalToConstant: 44),
            filmStripView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 11),
            exportButton.topAnchor.constraint(equalTo: topAnchor, constant: 11),
            exportButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -11),
            playButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -11),
            playButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 11),
            playbackView.heightAnchor.constraint(equalTo: drawingViewGuide.heightAnchor),
            playbackView.widthAnchor.constraint(equalTo: drawingViewGuide.widthAnchor),
            playbackView.centerXAnchor.constraint(equalTo: drawingViewGuide.centerXAnchor),
            playbackView.centerYAnchor.constraint(equalTo: drawingViewGuide.centerYAnchor)
        ])

        #if CLIP
        NSLayoutConstraint.activate([
            filmStripView.topAnchor.constraint(equalTo: topAnchor, constant: 11)
        ])
        #else
        NSLayoutConstraint.activate([
            filmStripView.topAnchor.constraint(equalTo: galleryButton.bottomAnchor, constant: 11),
            galleryButton.topAnchor.constraint(equalTo: topAnchor, constant: 11),
            galleryButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 11),
        ])
        #endif
    }

    private let drawingViewController: DrawingViewController
    private let statePublisher: EditingStatePublisher
    private let toolPicker: EditingToolPicker

    private lazy var filmStripView = FilmStripView(statePublisher: statePublisher)
    private let playButton = PlayButton()
    #if !CLIP
    private let galleryButton = GalleryButton()
    #endif
    private let exportButton = ExportButton()
    private lazy var playbackView = PlaybackView(statePublisher: statePublisher)

    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("\(String(describing: type(of: Self.self))) does not implement init(coder:)")
    }
}
