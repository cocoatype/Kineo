//  Created by Geoff Pado on 12/25/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import UIKit

class EditingViewCompactLayoutManager: NSObject, EditingViewLayoutManager {
    func layout(_ editingView: EditingView) {
        let drawingView = self.drawingView(in: editingView)
        let filmStripView = self.filmStripView(in: editingView)

        editingView.subviews
          .filter { $0 != drawingView && $0 != filmStripView }
          .forEach { $0.removeFromSuperview() }

        editingView.addSubview(playButton)
        editingView.addSubview(galleryButton)
        editingView.addSubview(exportButton)
        editingView.addSubview(toolsButton)

        NSLayoutConstraint.activate([
            galleryButton.topAnchor.constraint(equalTo: editingView.safeAreaLayoutGuide.topAnchor, constant: 11),
            galleryButton.leadingAnchor.constraint(equalTo: editingView.leadingAnchor, constant: 11),
            exportButton.topAnchor.constraint(equalTo: galleryButton.topAnchor),
            exportButton.leadingAnchor.constraint(equalTo: galleryButton.trailingAnchor, constant: 11),
            playButton.leadingAnchor.constraint(equalTo: galleryButton.leadingAnchor),
            playButton.bottomAnchor.constraint(equalTo: editingView.safeAreaLayoutGuide.bottomAnchor, constant: -11),
            toolsButton.trailingAnchor.constraint(equalTo: editingView.trailingAnchor, constant: -11),
            toolsButton.topAnchor.constraint(equalTo: galleryButton.topAnchor),
            drawingView.centerXAnchor.constraint(equalTo: editingView.centerXAnchor),
            drawingView.leadingAnchor.constraint(equalTo: editingView.leadingAnchor, constant: 11),
            drawingView.heightAnchor.constraint(equalTo: drawingView.widthAnchor),
            drawingView.centerYAnchor.constraint(equalTo: editingView.safeAreaLayoutGuide.centerYAnchor),
            filmStripView.leadingAnchor.constraint(equalTo: playButton.trailingAnchor, constant: 11),
            filmStripView.topAnchor.constraint(equalTo: playButton.topAnchor),
            filmStripView.bottomAnchor.constraint(equalTo: playButton.bottomAnchor),
            filmStripView.trailingAnchor.constraint(equalTo: toolsButton.trailingAnchor)
        ])
    }

    private let playButton = PlayButton()
    private let galleryButton = GalleryButton()
    private let exportButton = ExportButton()
    private let toolsButton = ToolsButton()
}
