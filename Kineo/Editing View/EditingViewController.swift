//  Created by Geoff Pado on 7/14/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import Data
import PencilKit
import UIKit

class EditingViewController: UIViewController {
    var document: Document { return documentEditor.document }
    init(document: Document) {
        self.documentEditor = DocumentEditor(document: document)
        super.init(nibName: nil, bundle: nil)

        NotificationCenter.default.addObserver(forName: Self.didUpdateDocument, object: nil, queue: .main) { [weak self] notification in
            guard let document = (notification.userInfo?[Self.updatedDocumentKey] as? Document), document.uuid == self?.documentEditor.document.uuid else { return }
            self?.documentEditor.document = document
            self?.updateCurrentPage()
        }
    }

    override func loadView() {
        let dataSource = EditingViewDataSource(documentEditor: documentEditor)
        view = Self.viewClass.init(dataSource: dataSource)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        editingView?.setupToolPicker()
        documentEditor.undoManager = undoManager
    }

    @objc func drawingViewDidChangePage(_ sender: DrawingView) {
        documentEditor.replaceCurrentPage(with: sender.page)
        updateCurrentPage()
        NotificationCenter.default.post(name: Self.didUpdateDocument, object: self, userInfo: [Self.documentUUIDKey: documentEditor.document.uuid, Self.updatedDocumentKey: documentEditor.document])
    }

    // MARK: Transport Controls

    @objc func play(_ sender: Any, for event: UIEvent) {
        guard (event.allTouches?.first?.tapCount ?? 1) == 1 else { return }
        editingView?.play(documentEditor.document, continuously: false)
    }

    @objc func playMultiple() {
        editingView?.play(documentEditor.document, continuously: true)
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

    @objc func undoDrawing() { undoManager?.undo(); updateCurrentPage() }
    @objc func redoDrawing() { undoManager?.redo(); updateCurrentPage() }

    // MARK: Boilerplate

    private static let didUpdateDocument = Notification.Name("EditingViewController.didUpdateDocument")
    private static let documentUUIDKey = "EditingViewController.documentUUIDKey"
    private static let updatedDocumentKey = "EditingViewController.updatedDocumentKey"

    private let documentEditor: DocumentEditor
    private var documentUpdateObserver: Any?

    class var viewClass: EditingView.Type { return EditingView.self }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
