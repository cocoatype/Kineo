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
    }

    override func loadView() { view = editingView }

    @objc func drawingViewDidChangePage(_ sender: DrawingView) {
        #warning("Make sure multi-window still works")
        state = EditingPageReplacement.updatedState(from: state, replacingCurrentPageWith: sender.page)
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

    @objc func addNewPage() { state = EditingPageAddition.updatedState(from: state) }

    @objc func deletePage(_ sender: UICommand) {
        guard let data = sender.propertyList as? Data,
              let page = try? JSONDecoder().decode(Page.self, from: data)
        else { return }
        state = state.removing(page)
    }

    @objc func duplicatePage(_ sender: UICommand) {
        guard let data = sender.propertyList as? Data, let page = try? JSONDecoder().decode(Page.self, from: data) else { return }
        state = EditingPageDuplication.updatedState(from: state, duplicating: page)
    }

    @objc func navigateToPage(_ sender: Any, for event: PageNavigationEvent) {
        state = EditingPageNavigation.updatedState(from: state, sender: sender, event: event)
    }

    @objc func startScrolling() { state = state.scrolling }
    @objc func stopScrolling() { state = state.editing }

    @objc func exportVideo(_ sender: Any) {
        present(ExportEditingNavigationController(document: document), animated: true)
    }

    // MARK: Editing View

    @objc func toggleToolPicker() {
        state = EditingState.Lenses.toolPickerShowing.set(state.toolPickerShowing.toggled, state)
    }

    // MARK: Undo/Redo

    @objc func undoDrawing() { undoManager?.undo() }
    @objc func redoDrawing() { undoManager?.redo() }

    // MARK: Boilerplate

    @Cascading private var state: EditingState
    private lazy var drawingViewController = DrawingViewController(publisher: $state)
    private lazy var editingView = EditingViewFactory.editingView(for: traitCollection, drawingViewController: drawingViewController, statePublisher: $state) {
        didSet {
            view = editingView
        }
    }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
