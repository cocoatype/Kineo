//  Created by Geoff Pado on 8/19/22.
//  Copyright © 2022 Cocoatype, LLC. All rights reserved.

import Data
import UIKit

class GalleryDocumentPreviewView: UIView {
    init(document: Document) {
        self.backgroundView = GalleryDocumentBackgroundView(document: document)
        self.playbackView = PlaybackView(document: document)
        super.init(frame: .zero)

        addSubview(backgroundView)
        addSubview(playbackView)

        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            playbackView.topAnchor.constraint(equalTo: topAnchor),
            playbackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            playbackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            playbackView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }

    // MARK: Playback

    private let playbackView: PlaybackView
    func startAnimating() { playbackView.startAnimating() }
    func stopAnimating() { playbackView.stopAnimating() }

    // MARK: Boilerplate

    private let backgroundView: GalleryDocumentBackgroundView

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
