//  Created by Geoff Pado on 7/14/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import Combine
import Data
import UIKit

class EditingViewController: UIViewController {
    var document: Document { state.document }

    init(document: Document) {
        self.state = EditingState(document: document)
        super.init(nibName: nil, bundle: nil)
        embed(drawingViewController, layoutGuide: editingView.drawingViewGuide)
        applicationStateManager.notificationHandler = { [weak self] in
            guard let self = self else { return }
            self.state = EditingState.Lenses.document.set($0.document, self.state)
        }
    }

    override func loadView() { view = editingView }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        editingView = EditingViewFactory.editingView(for: traitCollection, drawingViewController: drawingViewController, statePublisher: $state)
        embed(drawingViewController, layoutGuide: editingView.drawingViewGuide)
        drawingViewController.drawingView.becomeFirstResponder()

        guard let parent = parent else { return }
        editingView.frame = parent.view.bounds
    }

    @objc func drawingViewDidChangePage(_ sender: DrawingView) {
        state = state.replacingCurrentPage(with: sender.page)
    }

    override func preferredContentSizeDidChange(forChildContentContainer container: UIContentContainer) {
        super.preferredContentSizeDidChange(forChildContentContainer: container)
        dump(container.preferredContentSize, name: #function)
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        dump(size, name: #function)
    }

    // MARK: Keyboard Commands

    override var keyCommands: [UIKeyCommand]? { EditingKeyCommand.all }

    // MARK: Transport Controls

    @objc func play(_ sender: Any, for event: UIEvent) {
        guard (event.allTouches?.first?.tapCount ?? 1) == 1 else { return }
        #warning("Handle not playing continuously")
        state = state.playing
    }

    @objc func playMultiple() { state = state.playing }

    @objc func addNewPage() { state = state.addingNewPage() }

    @objc func deletePage(_ sender: UICommand) {
        guard let data = sender.propertyList as? Data,
              let page = try? JSONDecoder().decode(Page.self, from: data)
        else { return }
        state = state.removing(page)
    }

    @objc func duplicatePage(_ sender: UICommand) {
        guard let data = sender.propertyList as? Data, let page = try? JSONDecoder().decode(Page.self, from: data) else { return }
        state = state.duplicating(page)
    }

    @objc func movePage(_ sender: Any, for event: FilmStripMoveEvent) {
        state = state.movingPage(at: event.source, to: event.destination)
    }

    @objc func navigateToPage(_ sender: Any, for event: PageNavigationEvent) {
        state = state.navigating(sender: sender, event: event)
    }

    @objc func startScrolling() { state = state.scrolling }
    @objc func stopScrolling() { let newState = state.editing; state = newState }

    @objc func exportVideo(_ sender: Any) {
        present(ExportEditingNavigationController(document: document), animated: true)
    }

    // MARK: Editing View

    @objc func toggleToolPicker() {
        state = EditingState.Lenses.toolPickerShowing.set(state.toolPickerShowing.toggled, state)
    }

    // MARK: Undo/Redo

    @objc func undoDrawing() {
        undoManager?.undo()
    }
    @objc func redoDrawing() { undoManager?.redo() }

    // MARK: Boilerplate

    @Cascading private var state: EditingState
    private lazy var drawingViewController = DrawingViewController(publisher: $state)
    private lazy var editingView = EditingViewFactory.editingView(for: traitCollection, drawingViewController: drawingViewController, statePublisher: $state) {
        didSet {
            view = editingView
        }
    }
    private lazy var applicationStateManager = ApplicationEditingStateManager(statePublisher: $state)

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}

/*
 EditingState(currentPageIndex: 0, document: Data.Document(pages: [Data.Page(drawing: PencilKit.PKDrawing(drawing: <PKDrawingConcrete: 0x10ce639d0 926C 4 strokes>), uuid: 5814926F-9D6B-4A69-82D9-607300F017BE)], uuid: 2EA8CFC6-6E00-4E22-8137-9C80C9121EBB), mode: Kineo.EditingState.Mode.editing, toolPickerShowing: false) is equal to EditingState(currentPageIndex: 0, document: Data.Document(pages: [Data.Page(drawing: PencilKit.PKDrawing(drawing: <PKDrawingConcrete: 0x10dbc4e00 926C 4 strokes>), uuid: 5814926F-9D6B-4A69-82D9-607300F017BE)], uuid: 2EA8CFC6-6E00-4E22-8137-9C80C9121EBB), mode: Kineo.EditingState.Mode.editing, toolPickerShowing: false): true

 EditingState(currentPageIndex: 0, document: Data.Document(pages: [Data.Page(drawing: PencilKit.PKDrawing(drawing: <PKDrawingConcrete: 0x10db1a660 EDAD 5 strokes>), uuid: 1CE63E05-BEB5-435A-8C49-B7EEF2180050)], uuid: 2EA8CFC6-6E00-4E22-8137-9C80C9121EBB), mode: Kineo.EditingState.Mode.editing, toolPickerShowing: false) is equal to EditingState(currentPageIndex: 0, document: Data.Document(pages: [Data.Page(drawing: PencilKit.PKDrawing(drawing: <PKDrawingConcrete: 0x10ce639d0 926C 4 strokes>), uuid: 5814926F-9D6B-4A69-82D9-607300F017BE)], uuid: 2EA8CFC6-6E00-4E22-8137-9C80C9121EBB), mode: Kineo.EditingState.Mode.editing, toolPickerShowing: false): false
 EditingState(currentPageIndex: 0, document: Data.Document(pages: [Data.Page(drawing: PencilKit.PKDrawing(drawing: <PKDrawingConcrete: 0x10db1a660 EDAD 5 strokes>), uuid: 1CE63E05-BEB5-435A-8C49-B7EEF2180050)], uuid: 2EA8CFC6-6E00-4E22-8137-9C80C9121EBB), mode: Kineo.EditingState.Mode.editing, toolPickerShowing: false) was not equal to EditingState(currentPageIndex: 0, document: Data.Document(pages: [Data.Page(drawing: PencilKit.PKDrawing(drawing: <PKDrawingConcrete: 0x10ce639d0 926C 4 strokes>), uuid: 5814926F-9D6B-4A69-82D9-607300F017BE)], uuid: 2EA8CFC6-6E00-4E22-8137-9C80C9121EBB), mode: Kineo.EditingState.Mode.editing, toolPickerShowing: false)

 EditingState(
 currentPageIndex: 0,
 document: Data.Document(
   pages: [
     Data.Page(
       drawing: PencilKit.PKDrawing(drawing: <PKDrawingConcrete: 0x10db1a660 EDAD 5 strokes>),
       uuid: 1CE63E05-BEB5-435A-8C49-B7EEF2180050
     )
   ],
   uuid: 2EA8CFC6-6E00-4E22-8137-9C80C9121EBB),
   mode: Kineo.EditingState.Mode.editing,
   toolPickerShowing: false) is equal to EditingState(currentPageIndex: 0, document: Data.Document(pages: [Data.Page(drawing: PencilKit.PKDrawing(drawing: <PKDrawingConcrete: 0x10dbc4e00 926C 4 strokes>), uuid: 5814926F-9D6B-4A69-82D9-607300F017BE)], uuid: 2EA8CFC6-6E00-4E22-8137-9C80C9121EBB), mode: Kineo.EditingState.Mode.editing, toolPickerShowing: false): false
 EditingState(currentPageIndex: 0, document: Data.Document(pages: [Data.Page(drawing: PencilKit.PKDrawing(drawing: <PKDrawingConcrete: 0x10db1a660 EDAD 5 strokes>), uuid: 1CE63E05-BEB5-435A-8C49-B7EEF2180050)], uuid: 2EA8CFC6-6E00-4E22-8137-9C80C9121EBB), mode: Kineo.EditingState.Mode.editing, toolPickerShowing: false) was not equal to EditingState(currentPageIndex: 0, document: Data.Document(pages: [Data.Page(drawing: PencilKit.PKDrawing(drawing: <PKDrawingConcrete: 0x10dbc4e00 926C 4 strokes>), uuid: 5814926F-9D6B-4A69-82D9-607300F017BE)], uuid: 2EA8CFC6-6E00-4E22-8137-9C80C9121EBB), mode: Kineo.EditingState.Mode.editing, toolPickerShowing: false)

 */
