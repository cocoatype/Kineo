//  Created by Geoff Pado on 4/2/21.
//  Copyright © 2021 Cocoatype, LLC. All rights reserved.

import Data
import UIKit

class ExportEditingPreviewView: UIView {
    init(document: Document) {
        self.document = document
        self.playbackView = PlaybackView(document: document)
        self.edgeLengthConstraint = playbackView.heightAnchor.constraint(equalToConstant: 720)
        super.init(frame: .zero)

        translatesAutoresizingMaskIntoConstraints = false

        updateCanvas()

        addSubview(playbackView)
        addSubview(watermarkView)
        addLayoutGuide(watermarkPlacementGuide)

        playbackView.startAnimating()

        NSLayoutConstraint.activate([
            playbackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            playbackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            playbackView.widthAnchor.constraint(equalTo: playbackView.heightAnchor),
            watermarkPlacementGuide.topAnchor.constraint(equalTo: playbackView.bottomAnchor),
            watermarkPlacementGuide.centerXAnchor.constraint(equalTo: playbackView.centerXAnchor),
            watermarkPlacementGuide.heightAnchor.constraint(equalTo: playbackView.heightAnchor, multiplier: 16/512),
            watermarkPlacementGuide.widthAnchor.constraint(equalTo: playbackView.widthAnchor),
            watermarkView.topAnchor.constraint(equalTo: watermarkPlacementGuide.bottomAnchor),
            watermarkView.centerXAnchor.constraint(equalTo: watermarkPlacementGuide.centerXAnchor),
            watermarkView.widthAnchor.constraint(equalTo: watermarkPlacementGuide.widthAnchor, multiplier: ExportEditingPreviewWatermarkImageView.watermarkWidth / 512),
            edgeLengthConstraint
        ])

        edgeLengthConstraint.constant = playbackViewEdgeLength
    }

    func updateCanvas() {
        backgroundColor = Defaults.exportShape.isPlain ? .clear : .appBackground
        layer.cornerRadius = Defaults.exportShape.isPlain ? 0 : Constants.canvasCornerRadius
        playbackView.canvasBackgroundColor = Defaults.exportShape.isPlain ? .clear : document.canvasBackgroundColor
        watermarkView.alpha = Defaults.exportShape.isPlain ? 0 : 1
    }

    func replay() {
        playbackView.document = document
    }

    // MARK: Layout

    override func layoutSubviews() {
        super.layoutSubviews()
        let newEdgeLength = playbackViewEdgeLength
        guard edgeLengthConstraint.constant != newEdgeLength else { return }
        edgeLengthConstraint.constant = newEdgeLength
        layoutIfNeeded()
    }

    private var playbackViewEdgeLength: CGFloat {
        Self.sizeMultiplier * min(bounds.width, bounds.height)
    }

    override var intrinsicContentSize: CGSize { return CGSize(width: 720, height: 720) }

    // MARK: Boilerplate

    private static let sizeMultiplier = CGFloat(512.0/720.0)

    private let document: Document
    private let edgeLengthConstraint: NSLayoutConstraint
    private let playbackView: PlaybackView
    private let watermarkPlacementGuide = UILayoutGuide()
    private let watermarkView = ExportEditingPreviewWatermarkImageView()

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
