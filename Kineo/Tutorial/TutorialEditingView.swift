//  Created by Geoff Pado on 3/15/20.
//  Copyright © 2020 Cocoatype, LLC. All rights reserved.

import UIKit

class TutorialEditingView: EditingView {
    // MARK: Tutorial Steps

    private func hiddenViews(for step: TutorialStep) -> [UIView] {
        switch step {
        case .intro: return []
        case .drawing: return [filmStripView, playButton, toolsButton, undoButton, redoButton, exportButton]
        case .adding: return [playButton, toolsButton, undoButton, redoButton, exportButton]
        case .playing: return [toolsButton, undoButton, redoButton, exportButton]
        case .finished: return []
        }
    }

    func transition(from fromStep: TutorialStep, to toStep: TutorialStep, animated: Bool) {
        let fromHiddenViews = hiddenViews(for: fromStep)
        let toHiddenViews = hiddenViews(for: toStep)
        let diff = toHiddenViews.difference(from: fromHiddenViews)
        let addedViews = diff.compactMap { change -> UIView? in
            guard case .remove(_, let view, _) = change else { return nil }
            return view
        }
        let removedViews = diff.compactMap { change -> UIView? in
            guard case .insert(_, let view, _) = change else { return nil }
            return view
        }

        CATransaction.begin()
        CATransaction.setAnimationDuration(animated ? 0.35 : 0.0)
        CATransaction.setDisableActions(true)
        for view in addedViews {
            view.isHidden = false
            view.layer.add(OpacityAnimation(from: 0, to: 1), forKey: "viewOpacity")
        }
        for view in removedViews {
            view.isHidden = true
            view.layer.add(OpacityAnimation(from: 1, to: 0), forKey: "viewOpacity")
        }
        CATransaction.commit()
    }

    // MARK: Subviews

    private func firstSubview<ViewType: UIView>(of viewType: ViewType.Type) -> ViewType {
        guard let subview = (subviews.compactMap { $0 as? ViewType }.first) else {
            fatalError("Could not find subview of type \(ViewType.self) in \(self)")
        }

        return subview
    }

    private var filmStripView: FilmStripView { return firstSubview(of: FilmStripView.self) }
    private var playButton: PlayButton { return firstSubview(of: PlayButton.self) }
    private var galleryButton: GalleryButton { return firstSubview(of: GalleryButton.self) }
//    private var exportButton: ExportButton { return firstSubview(of: ExportButton.self) }
    private var toolsButton: ToolsButton { return firstSubview(of: ToolsButton.self) }
    private var undoButton: UndoButton { return firstSubview(of: UndoButton.self) }
    private var redoButton: RedoButton { return firstSubview(of: RedoButton.self) }
}
