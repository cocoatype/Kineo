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
        do {
            let promoText = Self.exportPromoText
            let videoProvider = try VideoProvider(document: documentEditor.document)

            let activityController = UIActivityViewController(activityItems: [promoText, videoProvider], applicationActivities: nil)
            if let popoverPresentationController = activityController.popoverPresentationController {
                popoverPresentationController.sourceView = sender
                popoverPresentationController.sourceRect = sender.bounds
            }
            present(activityController, animated: true, completion: nil)
        } catch { dump(error) }
    }

    // MARK: Editing View

    private var editingView: EditingView? { return view as? EditingView }

    private func updateCurrentPage() {
        editingView?.reloadData()
    }

    @objc func toggleToolPicker() {
        editingView?.toggleToolPicker()
    }

    @objc func undoDrawing() { undoManager?.undo() }
    @objc func redoDrawing() { undoManager?.redo() }

    // MARK: Boilerplate

    private static let exportPromoText = NSLocalizedString("EditingViewController.exportPromoText", comment: "Promo text shared when exporting videos")

    private let documentEditor: DocumentEditor

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
