//  Created by Geoff Pado on 7/14/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import Data
import UIKit

class SceneViewController: UIViewController {
    init() {
        super.init(nibName: nil, bundle: nil)
        embed(GalleryViewController())
    }

    override func loadView() {
        view = SceneView()
    }

    @objc func showGallery() {
        transition(to: GalleryViewController())
    }

    func showEditingView(for document: Document) {
        guard let galleryViewController = (children.first as? GalleryViewController) else { return }
        let editingViewController = EditingViewController(document: document)
        presentationDirector.animatePresentation(from: galleryViewController, to: editingViewController, in: self)
    }

    @objc func showEditingView(_ sender: GalleryViewController, for event: GallerySelectionEvent) {
        self.showEditingView(for: event.document)
    }

    @objc func presentHelp() {
        present(SettingsNavigationController(), animated: true)
    }

    @objc func dismissSettingsViewController(_ sender: SettingsViewController) {
        guard presentedViewController is SettingsNavigationController else { return }
        dismiss(animated: true, completion: nil)
    }

    // MARK: Status Bar

    override var prefersStatusBarHidden: Bool { return UIDevice.current.userInterfaceIdiom == .pad }

    // MARK: Boilerplate

    private let documentStore = DocumentStore()
    private let presentationDirector = PresentationDirector()

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
