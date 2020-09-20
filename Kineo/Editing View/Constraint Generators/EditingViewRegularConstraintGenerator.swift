//  Created by Geoff Pado on 2/29/20.
//  Copyright © 2020 Cocoatype, LLC. All rights reserved.

import UIKit

class EditingViewRegularConstraintGenerator: NSObject, EditingViewConstraintGenerator {
    let editingView: EditingView
    required init(editingView: EditingView) {
        self.editingView = editingView
    }

    lazy var constraints: [NSLayoutConstraint] = [
        drawingViewGuide.widthAnchor.constraint(equalTo: drawingViewGuide.heightAnchor),
        drawingViewGuide.widthAnchor.constraint(equalToConstant: 512.0),
        drawingViewGuide.centerXAnchor.constraint(equalTo: editingView.centerXAnchor),
        drawingViewGuide.centerYAnchor.constraint(equalTo: editingView.centerYAnchor),
        filmStripView.topAnchor.constraint(equalTo: galleryButton.bottomAnchor, constant: 11),
        filmStripView.bottomAnchor.constraint(equalTo: playButton.topAnchor, constant: -11),
        filmStripView.widthAnchor.constraint(equalToConstant: 44),
        filmStripView.leadingAnchor.constraint(equalTo: editingView.leadingAnchor, constant: 11),
        exportButton.topAnchor.constraint(equalTo: editingView.topAnchor, constant: 11),
        exportButton.trailingAnchor.constraint(equalTo: editingView.trailingAnchor, constant: -11),
        galleryButton.topAnchor.constraint(equalTo: editingView.topAnchor, constant: 11),
        galleryButton.leadingAnchor.constraint(equalTo: editingView.leadingAnchor, constant: 11),
        playButton.bottomAnchor.constraint(equalTo: editingView.bottomAnchor, constant: -11),
        playButton.leadingAnchor.constraint(equalTo: editingView.leadingAnchor, constant: 11),
        // hide all the unused buttons outside the view
        undoButton.leadingAnchor.constraint(equalTo: editingView.leadingAnchor),
        undoButton.topAnchor.constraint(equalTo: editingView.bottomAnchor, constant: 10),
        redoButton.centerXAnchor.constraint(equalTo: undoButton.centerXAnchor),
        redoButton.centerYAnchor.constraint(equalTo: undoButton.centerYAnchor),
        toolsButton.centerXAnchor.constraint(equalTo: undoButton.centerXAnchor),
        toolsButton.centerYAnchor.constraint(equalTo: undoButton.centerYAnchor)
    ]
}
