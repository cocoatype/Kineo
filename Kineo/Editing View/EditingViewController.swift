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

        if let view = view, let window = view.window {
            PKToolPicker.shared(for: window)?.setVisible(true, forFirstResponder: view)
        }
    }

    @objc func drawingViewDidChangePage(_ sender: DrawingView) {
        documentEditor.replaceCurrentPage(with: sender.page)
    }

    // MARK: Boilerplate

    private let documentEditor: DocumentEditor

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
