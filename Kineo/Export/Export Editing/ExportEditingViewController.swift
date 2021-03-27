//  Created by Geoff Pado on 3/12/21.
//  Copyright © 2021 Cocoatype, LLC. All rights reserved.

import Data
import UIKit

class ExportEditingViewController: UIViewController {
    init(document: Document) {
        self.document = document
        super.init(nibName: nil, bundle: nil)

        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissSelf))
    }

    override func loadView() {
        view = editingView
    }

    @objc private func dismissSelf() {
        dismiss(animated: true)
    }

    // MARK: Actions

    @objc func updatePlaybackStyle(_ sender: ExportEditingPlaybackStylePicker) {
        Defaults.exportPlaybackStyle = sender.selectedStyle
        editingView.replay()
    }

    // MARK: Boilerplate

    private let document: Document
    private lazy var editingView = ExportEditingView(document: document)

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
