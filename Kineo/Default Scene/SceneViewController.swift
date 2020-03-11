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

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if TutorialCoordinator.shouldStartTutorial {
            present(TutorialIntroViewController(), animated: true, completion: nil)
        }
    }

    // MARK: Actions

    @objc func showGallery() {
        let galleryViewController = GalleryViewController()
        guard children.count == 1, let editingViewController = (children.first as? EditingViewController) else { return transition(to: galleryViewController) }
        dismissalDirector.animateDismissal(from: editingViewController, to: galleryViewController, in: self)
    }

    func showEditingView(for document: Document) {
        let editingViewController = EditingViewController(document: document)
        guard children.count == 1, let galleryViewController = (children.first as? GalleryViewController) else { return transition(to: editingViewController) }
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

    @objc func dismissTutorial(_ sender: Any) {
        guard presentedViewController is TutorialIntroViewController else { return }
        dismiss(animated: true, completion: nil)
    }

    // MARK: Status Bar

    override var prefersStatusBarHidden: Bool { return UIDevice.current.userInterfaceIdiom == .pad }

    // MARK: Boilerplate

    private let documentStore = DocumentStore()
    private let presentationDirector = PresentationDirector()
    private let dismissalDirector = DismissalDirector()

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
