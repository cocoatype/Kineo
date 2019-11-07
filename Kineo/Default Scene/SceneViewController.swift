//  Created by Geoff Pado on 7/14/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import UIKit

class SceneViewController: UIViewController {
    init() {
        super.init(nibName: nil, bundle: nil)
        embed(EditingViewController(document: documentStore.sampleDocument))
    }

    @objc func showGallery() {
        transition(to: GalleryViewController())
    }

    @objc func showEditingView(_ sender: GalleryViewController, for event: GallerySelectionEvent) {
        transition(to: EditingViewController(document: event.document))
    }

    // MARK: Boilerplate

    private let documentStore = DocumentStore()

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
