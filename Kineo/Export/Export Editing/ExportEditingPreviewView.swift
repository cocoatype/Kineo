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

        playbackView.animate(continuously: true)

        NSLayoutConstraint.activate([
            playbackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            playbackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            playbackView.widthAnchor.constraint(equalTo: playbackView.heightAnchor),
            watermarkView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -21),
            watermarkView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
            edgeLengthConstraint
        ])

        edgeLengthConstraint.constant = playbackViewEdgeLength
    }

    func updateCanvas() {
        backgroundColor = Defaults.exportShape.isPlain ? .clear : .appBackground
        layer.cornerRadius = Defaults.exportShape.isPlain ? 0 : 8
        playbackView.backgroundColor = Defaults.exportShape.isPlain ? .canvasBackground : .clear
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
    private let watermarkView = ExportEditingPreviewWatermarkImageView()

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}

class ExportEditingPreviewWatermarkImageView: UIImageView {
    init() {
        super.init(frame: .zero)
        contentMode = .center
        image = Self.watermarkImage
        translatesAutoresizingMaskIntoConstraints = false

        setContentHuggingPriority(.required, for: .horizontal)
        setContentHuggingPriority(.required, for: .vertical)
        setContentCompressionResistancePriority(.required, for: .horizontal)
        setContentCompressionResistancePriority(.required, for: .vertical)
    }

    override var intrinsicContentSize: CGSize { Self.watermarkImage.size }

    // MARK: Boilerplate

    private static let watermarkImage: UIImage = {
        guard let image = UIImage(named: "Watermark") else { fatalError("Unable to load watermark image") }
        return image
    }()

    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("\(String(describing: type(of: Self.self))) does not implement init(coder:)")
    }
}
