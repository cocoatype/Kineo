//  Created by Geoff Pado on 7/14/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import Data
import PencilKit
import UIKit

class EditingView: UIView, PlaybackViewDelegate {
    init(dataSource: EditingViewDataSource) {
        self.dataSource = dataSource
        super.init(frame: .zero)

        backgroundColor = .appBackground

        addSubview(drawingView)
        addSubview(filmStripView)
        addSubview(playButton)
        addSubview(galleryButton)
        addSubview(exportButton)
        addSubview(toolsButton)
        addSubview(undoButton)
        addSubview(redoButton)

        NSLayoutConstraint.activate(constraints(for: traitCollection.horizontalSizeClass))

        reloadData()
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        setupToolPicker()

        let currentSizeClass = traitCollection.horizontalSizeClass
        guard let previousSizeClass = previousTraitCollection?.horizontalSizeClass, previousSizeClass != currentSizeClass else { return }
        NSLayoutConstraint.deactivate(constraints(for: previousSizeClass))
        NSLayoutConstraint.activate(constraints(for: currentSizeClass))
        toolsButton.isHidden = currentSizeClass == .regular
        undoButton.isHidden = currentSizeClass == .regular
        redoButton.isHidden = currentSizeClass == .regular
    }

    func reloadData() {
        dataSource.generateSkinsImage { [weak self] skinsImage in
            guard let editingView = self else { return }
            DispatchQueue.main.async {
                editingView.drawingView.display(page: editingView.dataSource.currentPage, skinsImage: skinsImage)
                editingView.playbackView?.document = editingView.dataSource.document
                editingView.filmStripView.reloadData()
            }
        }
    }

    func setupToolPicker() {
        guard let window = window,
          let toolPicker = PKToolPicker.shared(for: window)
        else { return }

        drawingView.observe(toolPicker)
        _ = drawingView.becomeFirstResponder()

        let alwaysShowToolPicker = traitCollection.horizontalSizeClass != .compact
        toolPicker.setVisible(alwaysShowToolPicker, forFirstResponder: drawingView)
    }

    func toggleToolPicker() {
        guard let window = window,
          let toolPicker = PKToolPicker.shared(for: window)
        else { return }

        toolPicker.setVisible(toolPicker.isVisible.toggled, forFirstResponder: drawingView)
        _ = drawingView.becomeFirstResponder()
    }

    // MARK: Playback

    private var playbackView: PlaybackView?

    func play(_ document: Document, continuously: Bool = false) {
        let playbackView: PlaybackView
        if let existingPlaybackView = self.playbackView {
            existingPlaybackView.document = document
            playbackView = existingPlaybackView
        } else {
            playbackView = PlaybackView(document: document)

            addSubview(playbackView)
            NSLayoutConstraint.activate([
                playbackView.widthAnchor.constraint(equalTo: drawingView.widthAnchor),
                playbackView.heightAnchor.constraint(equalTo: drawingView.heightAnchor),
                playbackView.centerXAnchor.constraint(equalTo: drawingView.centerXAnchor),
                playbackView.centerYAnchor.constraint(equalTo: drawingView.centerYAnchor)
            ])
        }

        playbackView.animate(continuously: continuously)
        playbackView.delegate = self
        self.playbackView = playbackView
    }

    func playbackViewDidFinishPlayback(_ playbackView: PlaybackView) {
        guard playbackView == self.playbackView else { return }
        playbackView.removeFromSuperview()
        self.playbackView = nil
    }

    // MARK: Boilerplate

    private lazy var drawingView = DrawingView(page: dataSource.currentPage)
    private lazy var filmStripView = FilmStripView(dataSource: dataSource)
    private let playButton = PlayButton()
    private let galleryButton = GalleryButton()
    private let exportButton = ExportButton()
    private let toolsButton = ToolsButton()
    private let undoButton = UndoButton()
    private let redoButton = RedoButton()

    private let dataSource: EditingViewDataSource

    private lazy var regularConstraints: [NSLayoutConstraint] = [
        drawingView.widthAnchor.constraint(equalTo: drawingView.heightAnchor),
        drawingView.widthAnchor.constraint(equalToConstant: 512.0),
        drawingView.centerXAnchor.constraint(equalTo: centerXAnchor),
        drawingView.centerYAnchor.constraint(equalTo: centerYAnchor),
        filmStripView.topAnchor.constraint(equalTo: galleryButton.bottomAnchor, constant: 11),
        filmStripView.bottomAnchor.constraint(equalTo: playButton.topAnchor, constant: -11),
        filmStripView.widthAnchor.constraint(equalToConstant: 44),
        filmStripView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 11),
        exportButton.topAnchor.constraint(equalTo: topAnchor, constant: 11),
        exportButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -11),
        galleryButton.topAnchor.constraint(equalTo: topAnchor, constant: 11),
        galleryButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 11),
        playButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -11),
        playButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 11),
        // hide all the unused buttons outside the view
        undoButton.leadingAnchor.constraint(equalTo: leadingAnchor),
        undoButton.topAnchor.constraint(equalTo: bottomAnchor, constant: 10),
        redoButton.centerXAnchor.constraint(equalTo: undoButton.centerXAnchor),
        redoButton.centerYAnchor.constraint(equalTo: undoButton.centerYAnchor),
        toolsButton.centerXAnchor.constraint(equalTo: undoButton.centerXAnchor),
        toolsButton.centerYAnchor.constraint(equalTo: undoButton.centerYAnchor)
    ]

    private lazy var compactConstraints: [NSLayoutConstraint] = [
        galleryButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 11),
        galleryButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 11),
        exportButton.topAnchor.constraint(equalTo: galleryButton.topAnchor),
        exportButton.leadingAnchor.constraint(equalTo: galleryButton.trailingAnchor, constant: 11),
        playButton.leadingAnchor.constraint(equalTo: galleryButton.leadingAnchor),
        playButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -11),
        toolsButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -11),
        toolsButton.topAnchor.constraint(equalTo: galleryButton.topAnchor),
        redoButton.trailingAnchor.constraint(equalTo: toolsButton.leadingAnchor, constant: -11),
        redoButton.centerYAnchor.constraint(equalTo: toolsButton.centerYAnchor),
        undoButton.trailingAnchor.constraint(equalTo: redoButton.leadingAnchor, constant: -11),
        undoButton.centerYAnchor.constraint(equalTo: toolsButton.centerYAnchor),
        drawingView.centerXAnchor.constraint(equalTo: centerXAnchor),
        drawingView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 11),
        drawingView.heightAnchor.constraint(equalTo: drawingView.widthAnchor),
        drawingView.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
        filmStripView.leadingAnchor.constraint(equalTo: playButton.trailingAnchor, constant: 11),
        filmStripView.topAnchor.constraint(equalTo: playButton.topAnchor),
        filmStripView.bottomAnchor.constraint(equalTo: playButton.bottomAnchor),
        filmStripView.trailingAnchor.constraint(equalTo: toolsButton.trailingAnchor)
    ]

    private func constraints(for sizeClass: UIUserInterfaceSizeClass) -> [NSLayoutConstraint] {
        switch sizeClass {
        case .compact: return compactConstraints
        case .regular: return regularConstraints
        case .unspecified: fallthrough
        @unknown default: return []
        }
    }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}

extension Bool {
    var toggled: Bool { return self == false }
}
