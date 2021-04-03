//  Created by Geoff Pado on 3/12/21.
//  Copyright © 2021 Cocoatype, LLC. All rights reserved.

import Data
import UIKit

class ExportEditingView: UIView {
    init(document: Document) {
        let previewView = ExportEditingPreviewView(document: document)
        self.aspectConstraint = previewView.widthAnchor.constraint(equalTo: previewView.heightAnchor, multiplier: Self.aspectRatio(for: Defaults.exportShape))
        self.previewView = previewView
        super.init(frame: .zero)

        backgroundColor = .black

        addSubview(pickerView)
        addSubview(previewView)

        NSLayoutConstraint.activate([
            pickerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            pickerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -57).withPriority(.defaultHigh),
            safeAreaLayoutGuide.bottomAnchor.constraint(equalToSystemSpacingBelow: pickerView.bottomAnchor, multiplier: 1),
            previewView.centerXAnchor.constraint(equalTo: centerXAnchor),
            previewView.centerYAnchor.constraint(equalTo: centerYAnchor),
            previewView.topAnchor.constraint(greaterThanOrEqualTo: topAnchor, constant: 140).withPriority(.defaultHigh),
            previewView.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 140).withPriority(.defaultHigh),
            previewView.widthAnchor.constraint(greaterThanOrEqualToConstant: 280).withPriority(.defaultHigh),
            previewView.topAnchor.constraint(greaterThanOrEqualTo: topAnchor, constant: 20),
            previewView.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 20),
            pickerView.topAnchor.constraint(greaterThanOrEqualToSystemSpacingBelow: previewView.bottomAnchor, multiplier: 1),
            aspectConstraint
        ])

        previewView.overrideUserInterfaceStyle = Defaults.exportBackgroundStyle
    }

    func updateInterfaceStyle() {
        guard self.previewView.overrideUserInterfaceStyle != Defaults.exportBackgroundStyle else { return }
        UIView.transition(with: self, duration: 0.5, options: .transitionCrossDissolve) {
            self.previewView.overrideUserInterfaceStyle = Defaults.exportBackgroundStyle
        } completion: { _ in }
    }

    func replay() {
        previewView.replay()
    }

    // MARK: Preview Layout

    func relayout() {
        aspectConstraint = aspectRatioConstraint(for: Defaults.exportShape)
        UIView.animate(withDuration: 0.5) { [unowned self] in
            self.previewView.updateCanvas()
            self.layoutIfNeeded()
        }
    }

    private static func aspectRatio(for exportShape: ExportShape) -> CGFloat {
        switch exportShape {
        case .landscape: return 16 / 9
        case .portrait: return 9 / 16
        case .square, .squarePlain: return 1
        }
    }

    private func aspectRatioConstraint(for exportShape: ExportShape) -> NSLayoutConstraint {
        let multiplier = Self.aspectRatio(for: exportShape)
        return previewView.widthAnchor.constraint(equalTo: previewView.heightAnchor, multiplier: multiplier)
    }

    private var aspectConstraint: NSLayoutConstraint {
        didSet {
            oldValue.isActive = false
            aspectConstraint.isActive = true
        }
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

        shapePicker.addTarget(nil, action: #selector(ExportEditingViewController.updateExportShape), for: .valueChanged)
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
        let selectedIndex = Self.shapes.firstIndex(of: Defaults.exportShape) ?? 0
        super.init(images: Self.images, selectedIndex: selectedIndex)
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
        let selectedIndex = Self.styles.firstIndex(of: Defaults.exportPlaybackStyle) ?? 0
        super.init(images: Self.images, selectedIndex: selectedIndex)
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
        self.edgeLengthConstraint = playbackView.heightAnchor.constraint(equalToConstant: 720)
        super.init(frame: .zero)

        translatesAutoresizingMaskIntoConstraints = false

        updateCanvas()

        addSubview(playbackView)

        playbackView.animate(continuously: true)

        NSLayoutConstraint.activate([
            playbackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            playbackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            playbackView.widthAnchor.constraint(equalTo: playbackView.heightAnchor),
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

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
