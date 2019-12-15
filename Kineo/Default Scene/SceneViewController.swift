//  Created by Geoff Pado on 7/14/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import UIKit

class SceneViewController: UIViewController {
    init() {
        super.init(nibName: nil, bundle: nil)
        embedInContainer(GalleryViewController())
    }

    override func loadView() {
        view = SceneView()
    }

    @objc func showGallery() {
        transitionInContainer(to: GalleryViewController())
    }

    func showEditingView(for document: Document) {
        transitionInContainer(to: EditingViewController(document: document))
    }

    @objc func showEditingView(_ sender: GalleryViewController, for event: GallerySelectionEvent) {
        self.showEditingView(for: event.document)
    }

    // MARK: Embedding

    func embedInContainer(_ newChild: UIViewController) {
        embed(newChild, embedView: containerView)
        updateSidebar(for: newChild as? SidebarActionProviding)
    }

    func transitionInContainer(to newChild: UIViewController) {
        transition(to: newChild, embedView: containerView)
        updateSidebar(for: newChild as? SidebarActionProviding)
    }

    private func updateSidebar(for newChild: SidebarActionProviding?) {
        let actionSet = newChild?.sidebarActions ?? ([],[],[])
        sidebarView.display(actionSet)
    }

    @objc func refreshSidebarActions() {
        guard let sidebarProvidingChild = (children.compactMap { $0 as? SidebarActionProviding }.first) else { return }
        sidebarView.display(sidebarProvidingChild.sidebarActions)
    }

    // MARK: Status Bar

    override var prefersStatusBarHidden: Bool { return true }

    // MARK: Boilerplate

    private let documentStore = DocumentStore()
    private var containerView: ContainerView { return sceneView.containerView }
    private var sidebarView: SidebarView { return sceneView.sidebarView }
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
