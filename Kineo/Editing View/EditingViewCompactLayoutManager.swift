//  Created by Geoff Pado on 12/25/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import UIKit

class EditingViewCompactLayoutManager: NSObject, EditingViewLayoutManager {
    func layout(_ editingView: EditingView) {
        let drawingView = self.drawingView(in: editingView)
        let filmStripView = self.filmStripView(in: editingView)
        let exportButton = self.exportButton(in: editingView)
        let galleryButton = self.galleryButton(in: editingView)
        let playButton = self.playButton(in: editingView)

        filmStripView.isHidden = true

        NSLayoutConstraint.activate([
            galleryButton.topAnchor.constraint(equalTo: editingView.safeAreaLayoutGuide.topAnchor, constant: 11),
            galleryButton.leadingAnchor.constraint(equalTo: editingView.leadingAnchor, constant: 11),
            exportButton.topAnchor.constraint(equalTo: galleryButton.topAnchor),
            exportButton.leadingAnchor.constraint(equalTo: galleryButton.trailingAnchor, constant: 11),
            playButton.leadingAnchor.constraint(equalTo: galleryButton.leadingAnchor),
            playButton.bottomAnchor.constraint(equalTo: editingView.safeAreaLayoutGuide.bottomAnchor, constant: -11),
            drawingView.centerXAnchor.constraint(equalTo: editingView.centerXAnchor),
            drawingView.leadingAnchor.constraint(equalTo: editingView.leadingAnchor, constant: 11),
            drawingView.heightAnchor.constraint(equalTo: drawingView.widthAnchor),
            drawingView.centerYAnchor.constraint(equalTo: editingView.safeAreaLayoutGuide.centerYAnchor)
        ])
    }
}
