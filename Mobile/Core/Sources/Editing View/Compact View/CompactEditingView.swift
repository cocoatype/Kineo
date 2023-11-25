//  Created by Geoff Pado on 9/4/21.
//  Copyright © 2021 Cocoatype, LLC. All rights reserved.

import CanvasPhone
import DataPhone
import EditingStatePhone
import PencilKit
import StylePhone
import UIKit

class CompactEditingView: EditingDrawView, CanvasDisplayingView {
    var drawingFrame: CGRect { drawingView.frame }
    var drawingSuperview: UIView { self }
    var drawingView: DrawingView { drawingViewController.drawingView }
    let drawingViewGuide = DrawingViewGuide()
    var canvasView: UIView { drawingView }

    var filmStripView: UIView { filmStripViewController.view }
    let filmStripViewGuide = FilmStripViewGuide()

    var backgroundPopoverSourceView: UIView? { nil }

    required init(statePublisher: EditingStatePublisher, drawingViewController: DrawingViewController, filmStripViewController: UIViewController) {
        self.drawingViewController = drawingViewController
        self.filmStripViewController = filmStripViewController
        self.statePublisher = statePublisher
        self.toolPicker = EditingToolPicker(statePublisher: statePublisher, drawingView: drawingViewController.drawingView)
        super.init(frame: .zero)

        autoresizingMask = [.flexibleWidth, .flexibleHeight]
        backgroundColor = Asset.background.color

        addLayoutGuide(drawingViewGuide)
        addLayoutGuide(filmStripViewGuide)

        [playButton, buttonBar, playbackView].forEach(self.addSubview(_:))

        NSLayoutConstraint.activate([
            buttonBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 11),
            buttonBar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 11),
            playButton.leadingAnchor.constraint(equalTo: buttonBar.leadingAnchor),
            playButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -11),
            buttonBar.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -11),
            drawingViewGuide.centerXAnchor.constraint(equalTo: centerXAnchor),
            drawingViewGuide.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 11),
            drawingViewGuide.heightAnchor.constraint(equalTo: drawingViewGuide.widthAnchor),
            drawingViewGuide.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            filmStripViewGuide.leadingAnchor.constraint(equalTo: playButton.trailingAnchor, constant: 11),
            filmStripViewGuide.topAnchor.constraint(equalTo: playButton.topAnchor),
            filmStripViewGuide.bottomAnchor.constraint(equalTo: playButton.bottomAnchor),
            filmStripViewGuide.trailingAnchor.constraint(equalTo: buttonBar.trailingAnchor),
            playbackView.heightAnchor.constraint(equalTo: drawingViewGuide.heightAnchor),
            playbackView.widthAnchor.constraint(equalTo: drawingViewGuide.widthAnchor),
            playbackView.centerXAnchor.constraint(equalTo: drawingViewGuide.centerXAnchor),
            playbackView.centerYAnchor.constraint(equalTo: drawingViewGuide.centerYAnchor)
        ])
    }

    private let drawingViewController: DrawingViewController
    private let filmStripViewController: UIViewController
    private let statePublisher: EditingStatePublisher
    private let toolPicker: EditingToolPicker

    private let playButton = PlayButton()
    private lazy var buttonBar = CompactEditingViewButtonBar(statePublisher: statePublisher)
    private lazy var playbackView = PlaybackView(statePublisher: statePublisher)

    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("\(String(describing: type(of: Self.self))) does not implement init(coder:)")
    }
}
