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

        [filmStripView, playButton, galleryButton, exportButton].forEach(self.addSubview(_:))

        NSLayoutConstraint.activate([
            drawingViewGuide.widthAnchor.constraint(equalTo: drawingViewGuide.heightAnchor),
            drawingViewGuide.widthAnchor.constraint(equalToConstant: 512.0),
            drawingViewGuide.centerXAnchor.constraint(equalTo: centerXAnchor),
            drawingViewGuide.centerYAnchor.constraint(equalTo: centerYAnchor),
            filmStripView.topAnchor.constraint(equalTo: galleryButton.bottomAnchor, constant: 11),
            filmStripView.bottomAnchor.constraint(equalTo: playButton.topAnchor, constant: -11),
            filmStripView.widthAnchor.constraint(equalToConstant: 44),
            filmStripView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 11),
            exportButton.topAnchor.constraint(equalTo: topAnchor, constant: 11),
            exportButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -11),
            galleryButton.topAnchor.constraint(equalTo: topAnchor, constant: 11),
            galleryButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 11),
            playButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -11),
            playButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 11)
        ])
    }

    private let drawingViewController: DrawingViewController
    private let statePublisher: EditingStatePublisher
    private let toolPicker: EditingToolPicker

    private lazy var filmStripView = FilmStripView(statePublisher: statePublisher)
    private let playButton = PlayButton()
    private let galleryButton = GalleryButton()
    private let exportButton = ExportButton()

    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("\(String(describing: type(of: Self.self))) does not implement init(coder:)")
    }
}
