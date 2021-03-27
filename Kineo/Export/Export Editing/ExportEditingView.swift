//  Created by Geoff Pado on 3/12/21.
//  Copyright © 2021 Cocoatype, LLC. All rights reserved.

import Data
import UIKit

class ExportEditingView: UIView {
    init(document: Document) {
        self.previewView = ExportEditingPreviewView(document: document)
        super.init(frame: .zero)

        backgroundColor = .black

        addSubview(pickerView)
        addSubview(previewView)

        NSLayoutConstraint.activate([
            pickerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            pickerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -57),
            previewView.centerXAnchor.constraint(equalTo: centerXAnchor),
            previewView.centerYAnchor.constraint(equalTo: centerYAnchor),
            previewView.topAnchor.constraint(greaterThanOrEqualTo: topAnchor, constant: 140),
            previewView.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 140),
            previewView.widthAnchor.constraint(equalTo: previewView.heightAnchor, multiplier: 16/9),
        ])
    }

    func replay() {
        previewView.replay()
    }

    // MARK: Boilerplate

    private let pickerView = ExportEditingPickerStackView()
    private let previewView: ExportEditingPreviewView

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}

class ExportEditingPickerStackView: UIStackView {
    init() {
        super.init(frame: .zero)

        playbackStylePicker.addTarget(nil, action: #selector(ExportEditingViewController.updatePlaybackStyle), for: .valueChanged)

        addArrangedSubview(shapePicker)
        addArrangedSubview(playbackStylePicker)

        spacing = UIStackView.spacingUseSystem
        translatesAutoresizingMaskIntoConstraints = false
    }

    // MARK: Boilerplate

    private let playbackStylePicker = ExportEditingPlaybackStylePicker()
    private let shapePicker = ExportEditingShapePicker()

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}

class ExportEditingShapePicker: ExportEditingPickerControl {
    init() {
        super.init(images: Self.images)
    }

    var selectedShape: ExportShape { Self.shapes[selectedIndex] }

    override var intrinsicContentSize: CGSize { return CGSize(width: 212, height: 46) }

    private static let images = [
        Icons.Export.square,
        Icons.Export.landscape,
        Icons.Export.portrait,
        Icons.Export.squarePlain,
    ]

    private static let shapes = [
        ExportShape.square,
        .landscape,
        .portrait,
        .squarePlain
    ]
}

class ExportEditingPlaybackStylePicker: ExportEditingPickerControl {
    init() {
        super.init(images: Self.images)
    }

    var selectedStyle: PlaybackStyle { Self.styles[selectedIndex] }

    override var intrinsicContentSize: CGSize { return CGSize(width: 106, height: 46) }

    private static let images = [
        Icons.Export.loop,
        Icons.Export.bounce
    ]

    private static let styles = [
        PlaybackStyle.loop,
        .bounce
    ]
}

class ExportEditingPreviewView: UIView {
    init(document: Document) {
        self.document = document
        self.playbackView = PlaybackView(document: document)
        super.init(frame: .zero)

        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .appBackground

        layer.cornerRadius = 8

        addSubview(playbackView)

        playbackView.animate(continuously: true)

        NSLayoutConstraint.activate([
            playbackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            playbackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            playbackView.widthAnchor.constraint(equalTo: playbackView.heightAnchor),
            playbackView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 512 / 720)
        ])
    }

    func replay() {
        playbackView.document = document
    }

    override var intrinsicContentSize: CGSize { return CGSize(width: 1280, height: 720) }

    // MARK: Boilerplate

    private let document: Document
    private let playbackView: PlaybackView

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
