//  Created by Geoff Pado on 2/11/22.
//  Copyright © 2022 Cocoatype, LLC. All rights reserved.

import Core
import DataPhone
import UIKit

class SceneViewController: UIViewController {
    init(document: Document?) {
        super.init(nibName: nil, bundle: nil)
        let initialViewController: UIViewController = EditingViewController(document: documentStore.newDocument())

        embed(initialViewController)
    }

    override func loadView() {
        view = SceneView()
    }

    // MARK: Status Bar

    override var prefersStatusBarHidden: Bool { return UIDevice.current.userInterfaceIdiom == .pad }

    // MARK: Actions

    @objc func showGallery() {
        let alert = GalleryNotImplementedAlertFactory.newAlert()
        present(alert, animated: true)
    }

    // MARK: Boilerplate

    private let documentStore = FileDocumentStore()

    private var sceneView: SceneView {
        guard let sceneView = view as? SceneView else { fatalError("Incorrect view type: \(String(describing: view))") }
        return sceneView
    }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
