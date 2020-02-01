//  Created by Geoff Pado on 7/14/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import Data
import PencilKit
import UIKit

class EditingViewController: UIViewController {
    init(document: Document) {
        self.documentEditor = DocumentEditor(document: document)
        super.init(nibName: nil, bundle: nil)
    }

    override func loadView() {
        let dataSource = EditingViewDataSource(documentEditor: documentEditor)
        view = EditingView(dataSource: dataSource)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        editingView?.setupToolPicker()
    }

    @objc func drawingViewDidChangePage(_ sender: DrawingView) {
        documentEditor.replaceCurrentPage(with: sender.page)
        updateCurrentPage()
    }

    // MARK: Transport Controls

    @objc func play(_ sender: Any, for event: UIEvent) {
        let tapCount = event.allTouches?.first?.tapCount ?? 1
        editingView?.play(documentEditor.document, continuously: tapCount > 1)
    }

    @objc func addNewPage() {
        documentEditor.addNewPage()
        updateCurrentPage()
    }

    @objc func navigateToPage(_ sender: FilmStripView, for event: PageNavigationEvent) {
        guard documentEditor.currentIndex != event.pageIndex else { return }
        documentEditor.navigate(toPageAt: event.pageIndex)
        updateCurrentPage()
    }

    @objc func exportVideo(_ sender: SidebarActionButton) {
        guard let activityController = ExportViewController(document: documentEditor.document, sourceView: sender) else { return }
        present(activityController, animated: true, completion: nil)
    }

    // MARK: Editing View

    private var editingView: EditingView? { return view as? EditingView }

    private func updateCurrentPage() {
        editingView?.reloadData()
    }

    @objc func toggleToolPicker() {
        editingView?.toggleToolPicker()
    }

    // MARK: Undo/Redo

    @objc func undoDrawing() { documentEditor.undo(); updateCurrentPage() }
    @objc func redoDrawing() { documentEditor.redo(); updateCurrentPage() }

    // MARK: Boilerplate

    private let documentEditor: DocumentEditor

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
