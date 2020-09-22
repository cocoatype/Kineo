//  Created by Geoff Pado on 2/29/20.
//  Copyright © 2020 Cocoatype, LLC. All rights reserved.

import UIKit

class EditingViewCompactConstraintGenerator: NSObject, EditingViewConstraintGenerator {
    let editingView: EditingView
    required init(editingView: EditingView) {
        self.editingView = editingView
    }

    lazy var constraints: [NSLayoutConstraint] = [
        galleryButton.topAnchor.constraint(equalTo: editingView.safeAreaLayoutGuide.topAnchor, constant: 11),
        galleryButton.leadingAnchor.constraint(equalTo: editingView.leadingAnchor, constant: 11),
        exportButton.topAnchor.constraint(equalTo: galleryButton.topAnchor),
        exportButton.leadingAnchor.constraint(equalTo: galleryButton.trailingAnchor, constant: 11),
        playButton.leadingAnchor.constraint(equalTo: galleryButton.leadingAnchor),
        playButton.bottomAnchor.constraint(equalTo: editingView.safeAreaLayoutGuide.bottomAnchor, constant: -11),
        toolsButton.trailingAnchor.constraint(equalTo: editingView.trailingAnchor, constant: -11),
        toolsButton.topAnchor.constraint(equalTo: galleryButton.topAnchor),
        redoButton.trailingAnchor.constraint(equalTo: toolsButton.leadingAnchor, constant: -11),
        redoButton.centerYAnchor.constraint(equalTo: toolsButton.centerYAnchor),
        undoButton.trailingAnchor.constraint(equalTo: redoButton.leadingAnchor, constant: -11),
        undoButton.centerYAnchor.constraint(equalTo: toolsButton.centerYAnchor),
        drawingViewGuide.centerXAnchor.constraint(equalTo: editingView.centerXAnchor),
        drawingViewGuide.leadingAnchor.constraint(equalTo: editingView.leadingAnchor, constant: 11),
        drawingViewGuide.heightAnchor.constraint(equalTo: drawingViewGuide.widthAnchor),
        drawingViewGuide.centerYAnchor.constraint(equalTo: editingView.safeAreaLayoutGuide.centerYAnchor),
        filmStripView.leadingAnchor.constraint(equalTo: playButton.trailingAnchor, constant: 11),
        filmStripView.topAnchor.constraint(equalTo: playButton.topAnchor),
        filmStripView.bottomAnchor.constraint(equalTo: playButton.bottomAnchor),
        filmStripView.trailingAnchor.constraint(equalTo: toolsButton.trailingAnchor)
    ]
}
