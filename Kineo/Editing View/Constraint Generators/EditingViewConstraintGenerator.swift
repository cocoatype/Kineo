//  Created by Geoff Pado on 2/29/20.
//  Copyright © 2020 Cocoatype, LLC. All rights reserved.

import UIKit

//protocol EditingViewConstraintGenerator {
//    init(editingView: EditingView)
//    var editingView: EditingView { get }
//    var constraints: [NSLayoutConstraint] { get }
//}
//
//extension EditingViewConstraintGenerator {
//    private func firstSubview<ViewType: UIView>(of viewType: ViewType.Type) -> ViewType {
//        guard let subview = (editingView.subviews.compactMap { $0 as? ViewType }.first) else {
//            fatalError("Could not find subview of type \(ViewType.self) in \(editingView)")
//        }
//
//        return subview
//    }
//
//    private func firstLayoutGuide(with identifier: String) -> UILayoutGuide {
//        guard let guide = (editingView.layoutGuides.first(where: { $0.identifier == identifier})) else {
//            fatalError("Could not find guide with identifier \(identifier) in \(editingView)")
//        }
//
//        return guide
//    }
//
//    var drawingViewGuide: UILayoutGuide { return firstLayoutGuide(with: EditingView.drawingViewGuideIdentifier) }
//    var filmStripView: FilmStripView { return firstSubview(of: FilmStripView.self) }
//    var playButton: PlayButton { return firstSubview(of: PlayButton.self) }
//    var galleryButton: GalleryButton { return firstSubview(of: GalleryButton.self) }
//    var exportButton: ExportButton { return firstSubview(of: ExportButton.self) }
//    var toolsButton: ToolsButton { return firstSubview(of: ToolsButton.self) }
//    var undoButton: UndoButton { return firstSubview(of: UndoButton.self) }
//    var redoButton: RedoButton { return firstSubview(of: RedoButton.self) }
//}
