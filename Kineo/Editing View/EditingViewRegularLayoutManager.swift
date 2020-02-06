//  Created by Geoff Pado on 12/25/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import UIKit

class EditingViewRegularLayoutManager: NSObject, EditingViewLayoutManager {
    func layout(_ editingView: EditingView) {
        let drawingView = self.drawingView(in: editingView)
        let filmStripView = self.filmStripView(in: editingView)

        editingView.subviews
          .filter { $0 != drawingView && $0 != filmStripView }
          .forEach { $0.removeFromSuperview() }

        editingView.addSubview(playButton)
        editingView.addSubview(galleryButton)
        editingView.addSubview(exportButton)

        NSLayoutConstraint.activate([
            drawingView.widthAnchor.constraint(equalTo: drawingView.heightAnchor),
            drawingView.widthAnchor.constraint(equalToConstant: 512.0),
            drawingView.centerXAnchor.constraint(equalTo: editingView.centerXAnchor),
            drawingView.centerYAnchor.constraint(equalTo: editingView.centerYAnchor),
            filmStripView.topAnchor.constraint(equalTo: galleryButton.bottomAnchor, constant: 11),
            filmStripView.bottomAnchor.constraint(equalTo: playButton.topAnchor, constant: -11),
            filmStripView.widthAnchor.constraint(equalToConstant: 44),
            filmStripView.leadingAnchor.constraint(equalTo: editingView.leadingAnchor, constant: 11),
            exportButton.topAnchor.constraint(equalTo: editingView.topAnchor, constant: 11),
            exportButton.trailingAnchor.constraint(equalTo: editingView.trailingAnchor, constant: -11),
            galleryButton.topAnchor.constraint(equalTo: editingView.topAnchor, constant: 11),
            galleryButton.leadingAnchor.constraint(equalTo: editingView.leadingAnchor, constant: 11),
            playButton.bottomAnchor.constraint(equalTo: editingView.bottomAnchor, constant: -11),
            playButton.leadingAnchor.constraint(equalTo: editingView.leadingAnchor, constant: 11)
        ])
    }

    private let playButton = PlayButton()
    private let galleryButton = GalleryButton()
    private let exportButton = ExportButton()
}