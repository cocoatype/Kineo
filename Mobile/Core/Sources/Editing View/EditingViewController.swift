//  Created by Geoff Pado on 8/8/22.
//  Copyright © 2022 Cocoatype, LLC. All rights reserved.

import DataPhone
import UIKit

public class EditingViewController: UIViewController {
    public let document: Document
    public init(document: Document) {
        self.document = document
        super.init(nibName: nil, bundle: nil)

        embed(EditingDrawViewController(document: document))
    }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }

    // MARK: Drawing

    public var canvasDisplayView: CanvasDisplayingView? {
        children.compactMap { $0.view as? CanvasDisplayingView }.first
    }

    // MARK: Exporting

    @objc func exportVideo(_ sender: Any) {
        present(ExportEditingNavigationController(document: document), animated: true)
    }

    // MARK: Display Mode

    @objc func setDrawDisplayMode(_ sender: Any) {
        transition(to: EditingDrawViewController(document: document))
    }

    @objc func setPlayDisplayMode(_ sender: Any) {
        transition(to: EditingPlayViewController(document: document))
    }

    @objc func setFramesDisplayMode(_ sender: Any) {}

    @objc func setCompareDisplayMode(_ sender: Any) {}
}
