//  Created by Geoff Pado on 9/4/21.
//  Copyright © 2021 Cocoatype, LLC. All rights reserved.

import Data
import PencilKit
import UIKit

class CompactEditingView: EditingView {
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

        [filmStripView, playButton, buttonBar].forEach(self.addSubview(_:))

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
            filmStripView.leadingAnchor.constraint(equalTo: playButton.trailingAnchor, constant: 11),
            filmStripView.topAnchor.constraint(equalTo: playButton.topAnchor),
            filmStripView.bottomAnchor.constraint(equalTo: playButton.bottomAnchor),
            filmStripView.trailingAnchor.constraint(equalTo: buttonBar.trailingAnchor)
        ])
    }

    private let drawingViewController: DrawingViewController
    private let statePublisher: EditingStatePublisher
    private let toolPicker: EditingToolPicker

    private lazy var filmStripView = FilmStripView(statePublisher: statePublisher)
    private let playButton = PlayButton()
    private lazy var buttonBar = CompactEditingViewButtonBar(statePublisher: statePublisher)

    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("\(String(describing: type(of: Self.self))) does not implement init(coder:)")
    }
}
