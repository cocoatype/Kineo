//  Created by Geoff Pado on 7/14/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import Data
import PencilKit
import UIKit

class EditingView: UIView, PlaybackViewDelegate {
    required init(dataSource: EditingViewDataSource) {
        self.dataSource = dataSource
        super.init(frame: .zero)

        backgroundColor = .appBackground

        [drawingView, filmStripView, playButton, galleryButton, exportButton, toolsButton, undoButton, redoButton].forEach(self.addSubview(_:))

        NSLayoutConstraint.activate(constraints(for: traitCollection.horizontalSizeClass))

        reloadData()
    }

    // MARK: Layout

    var drawingFrame: CGRect { return drawingView.frame }

    private(set) lazy var drawingView = DrawingView(page: dataSource.currentPage)
    private lazy var filmStripView = FilmStripView(dataSource: dataSource)
    private let playButton = PlayButton()
    private let galleryButton = GalleryButton()
    private let exportButton = ExportButton()
    private let toolsButton = ToolsButton()
    private let undoButton = UndoButton()
    private let redoButton = RedoButton()

    private lazy var compactConstraintGenerator = EditingViewCompactConstraintGenerator(editingView: self)
    private lazy var regularConstraintGenerator = EditingViewRegularConstraintGenerator(editingView: self)
    private func constraints(for sizeClass: UIUserInterfaceSizeClass) -> [NSLayoutConstraint] {
        switch sizeClass {
        case .compact: return compactConstraintGenerator.constraints
        case .regular: return regularConstraintGenerator.constraints
        case .unspecified: fallthrough
        @unknown default: return []
        }
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

    // MARK: Data

    private let dataSource: EditingViewDataSource
    func reloadData(includingFilmStrip: Bool = true) {
        undoButton.isEnabled = undoManager?.canUndo ?? false
        redoButton.isEnabled = undoManager?.canRedo ?? false
        drawingView.display(page: dataSource.currentPage, skinsImage: nil)
        playbackView?.document = dataSource.document

        dataSource.generateSkinsImage { [weak self] skinsImage, pageIndex in
            guard let editingView = self, pageIndex == editingView.dataSource.currentPageIndex else { return }
            DispatchQueue.main.async {
                editingView.drawingView.display(page: editingView.dataSource.currentPage, skinsImage: skinsImage)
                if includingFilmStrip {
                    editingView.filmStripView.reloadData()
                }
            }
        }
    }

    // MARK: Skins Images

    func hideSkinsImage() { drawingView.hideSkinsImage() }
    func showSkinsImage() { drawingView.showSkinsImage() }

    // MARK: Tool Picker

    private var toolPicker: PKToolPicker? {
        guard let window = window, let toolPicker = PKToolPicker.shared(for: window) else { return nil }
        return toolPicker
    }

    func setupToolPicker() {
        guard let toolPicker = toolPicker else { return }

        drawingView.observe(toolPicker)
        _ = drawingView.becomeFirstResponder()

        let alwaysShowToolPicker = traitCollection.horizontalSizeClass != .compact
        toolPicker.setVisible(alwaysShowToolPicker, forFirstResponder: drawingView)
    }

    func resetToolPicker() {
        guard let toolPicker = toolPicker else { return }
        if toolPicker.selectedTool is PKEraserTool {
            toolPicker.selectedTool = PKInkingTool(.pen)
        }
    }

    func toggleToolPicker() {
        guard let toolPicker = toolPicker else { return }
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

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}

extension Bool {
    var toggled: Bool { return self == false }
}
