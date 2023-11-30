//  Created by Geoff Pado on 1/31/20.
//  Copyright © 2020 Cocoatype, LLC. All rights reserved.

import DataPhone
import UIKit

class GalleryDocumentPreviewViewController: UIViewController {
    init(document: Document) {
        self.document = document
        self.previewView = GalleryDocumentPreviewView(document: document)
        super.init(nibName: nil, bundle: nil)
    }

    override func loadView() {
        view = previewView
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        previewView.startAnimating()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        previewView.stopAnimating()
    }

    override var preferredContentSize: CGSize {
        get { return Constants.canvasSize }
        set {}
    }

    // MARK: Boilerplate

    private let document: Document
    private let previewView: GalleryDocumentPreviewView

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
