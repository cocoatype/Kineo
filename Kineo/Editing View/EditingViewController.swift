//  Created by Geoff Pado on 7/14/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import PencilKit
import UIKit

class EditingViewController: UIViewController {
    init(document: Document) {
        self.documentEditor = DocumentEditor(document: document)
        super.init(nibName: nil, bundle: nil)
    }

    override func loadView() {
        view = EditingView(page: documentEditor.currentPage)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        editingView?.setupToolPicker()
    }

    @objc func drawingViewDidChangePage(_ sender: DrawingView) {
        documentEditor.replaceCurrentPage(with: sender.page)
    }

    // MARK: Transport Controls

    @objc func addPage() {
        documentEditor.addPage()
        updateCurrentPage()
    }

    @objc func playOneLoop() {
        editingView?.play(documentEditor.document)
    }

    @objc func advancePage() {
        documentEditor.advancePage()
        updateCurrentPage()
    }

    @objc func retreatPage() {
        documentEditor.retreatPage()
        updateCurrentPage()
    }

    // MARK: Editing View

    private var editingView: EditingView? { return view as? EditingView }

    private lazy var skinGenerator = SkinGenerator(traitCollection: traitCollection)

    private func updateCurrentPage() {
        editingView?.page = documentEditor.currentPage
        editingView?.skinsImage = skinGenerator.skinsImage(from: documentEditor.document, currentPageIndex: documentEditor.currentIndex)
    }

    // MARK: Boilerplate

    private let documentEditor: DocumentEditor

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        skinGenerator.traitCollection = traitCollection
    }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
