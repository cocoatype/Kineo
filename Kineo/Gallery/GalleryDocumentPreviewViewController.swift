//  Created by Geoff Pado on 1/31/20.
//  Copyright © 2020 Cocoatype, LLC. All rights reserved.

import Data
import UIKit

class GalleryDocumentPreviewViewController: UIViewController {
    init(document: Document) {
        self.document = document
        super.init(nibName: nil, bundle: nil)
    }

    override func loadView() {
        let playbackView = PlaybackView(document: document)
        playbackView.translatesAutoresizingMaskIntoConstraints = true
        view = playbackView
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        playbackView?.animate(continuously: true)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        playbackView?.stopAnimating()
    }

    override var preferredContentSize: CGSize {
        get { return Constants.canvasSize }
        set {}
    }

    // MARK: Boilerplate

    private let document: Document
    private var playbackView: PlaybackView? { return view as? PlaybackView }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
