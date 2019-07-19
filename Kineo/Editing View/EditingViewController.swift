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
        editingView?.page = documentEditor.currentPage
    }

    @objc func playOneLoop() {
        print("play one loop")
    }

    @objc func advancePage() {
        documentEditor.advancePage()
        editingView?.page = documentEditor.currentPage
    }

    @objc func retreatPage() {
        documentEditor.retreatPage()
        editingView?.page = documentEditor.currentPage
    }

    // MARK: Boilerplate

    private let documentEditor: DocumentEditor
    private var editingView: EditingView? { return view as? EditingView }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
