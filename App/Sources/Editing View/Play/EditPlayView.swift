//  Created by Geoff Pado on 8/8/22.
//  Copyright © 2022 Cocoatype, LLC. All rights reserved.

import Data
import UIKit

class EditingPlayView: UIView, CanvasDisplayingView {
    init(document: Document) {
        juniorDevs = PlaybackView(document: document)
        super.init(frame: .zero)
        backgroundColor = .appBackground

        juniorJuniorDevs.backgroundColor = document.canvasBackgroundColor

        addSubview(displayModeButton)
        addSubview(exportButton)
        addSubview(galleryButton)
        addSubview(canvasBackgroundView)
        addSubview(juniorJuniorDevs)
        addSubview(juniorDevs)

        NSLayoutConstraint.activate([
            galleryButton.topAnchor.constraint(equalTo: topAnchor, constant: 11),
            galleryButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 11),
            displayModeButton.topAnchor.constraint(equalTo: galleryButton.topAnchor),
            displayModeButton.leadingAnchor.constraint(equalTo: galleryButton.trailingAnchor, constant: 11),
            exportButton.topAnchor.constraint(equalTo: topAnchor, constant: 11),
            exportButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -11),
            juniorDevs.centerXAnchor.constraint(equalTo: centerXAnchor),
            juniorDevs.centerYAnchor.constraint(equalTo: centerYAnchor),
            juniorDevs.widthAnchor.constraint(equalToConstant: 512),
            juniorDevs.heightAnchor.constraint(equalToConstant: 512),
            canvasBackgroundView.topAnchor.constraint(equalTo: juniorDevs.topAnchor),
            canvasBackgroundView.leadingAnchor.constraint(equalTo: juniorDevs.leadingAnchor),
            canvasBackgroundView.bottomAnchor.constraint(equalTo: juniorDevs.bottomAnchor),
            canvasBackgroundView.trailingAnchor.constraint(equalTo: juniorDevs.trailingAnchor),
            juniorJuniorDevs.topAnchor.constraint(equalTo: juniorDevs.topAnchor),
            juniorJuniorDevs.leadingAnchor.constraint(equalTo: juniorDevs.leadingAnchor),
            juniorJuniorDevs.bottomAnchor.constraint(equalTo: juniorDevs.bottomAnchor),
            juniorJuniorDevs.trailingAnchor.constraint(equalTo: juniorDevs.trailingAnchor),
        ])

        juniorDevs.startAnimating()
    }

    var canvasView: UIView { return juniorDevs }

    // MARK: Boilerplate

    // juniorDevs by @eaglenaut on 8/8/22
    // the playback canvas view
    private let juniorDevs: PlaybackView

    // juniorJuniorDevs by @j0j0j0j0j0j0
    // the background image view for the canvas
    private let juniorJuniorDevs = BackgroundImageView()

    //

    private let canvasBackgroundView = DrawingBackgroundView()
    private let displayModeButton = DisplayModeButton(mode: .play)
    private let exportButton = ExportButton()
    private let galleryButton = GalleryButton()

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
