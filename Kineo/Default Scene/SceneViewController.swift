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

    @objc func showEditingView(_ sender: GalleryViewController, for event: GallerySelectionEvent) {
        transitionInContainer(to: EditingViewController(document: event.document))
    }

    // MARK: Embedding

    func embedInContainer(_ newChild: UIViewController) {
        embed(newChild, embedView: containerView)
    }

    func transitionInContainer(to newChild: UIViewController) {
        transition(to: newChild, embedView: containerView)
    }

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

class SceneView: UIView {
    init() {
        super.init(frame: .zero)

        backgroundColor = .appBackground

        addSubview(containerView)
        addSubview(sidebarView)

        NSLayoutConstraint.activate([
            sidebarView.widthAnchor.constraint(equalToConstant: Self.sidebarWidth),
            sidebarView.leadingAnchor.constraint(equalTo: leadingAnchor),
            sidebarView.centerYAnchor.constraint(equalTo: centerYAnchor),
            sidebarView.heightAnchor.constraint(equalTo: heightAnchor),
            containerView.leadingAnchor.constraint(equalTo: sidebarView.trailingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.heightAnchor.constraint(equalTo: heightAnchor),
            containerView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    // MARK: Boilerplate

    private static let sidebarWidth = CGFloat(66)

    let containerView = ContainerView()
    let sidebarView = SidebarView()

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}

class SidebarView: UIView {
    init() {
        super.init(frame: .zero)
        backgroundColor = .sidebarBackground
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
    }

    override func draw(_ rect: CGRect) {
        let screen = window?.screen ?? UIScreen.main
        let pixelWidth = 1 / screen.scale

        let xPosition = bounds.maxX - (pixelWidth / 2)
        let borderPath = UIBezierPath()
        borderPath.lineWidth = pixelWidth
        borderPath.move(to: CGPoint(x: xPosition, y: bounds.minY - pixelWidth))
        borderPath.addLine(to: CGPoint(x: xPosition, y: bounds.maxY + pixelWidth))

        UIColor.sidebarBorder.setStroke()
        borderPath.stroke()
    }

    // MARK: Boilerplate

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}

class ContainerView: UIView {
    init() {
        super.init(frame: .zero)
        backgroundColor = .appBackground
        translatesAutoresizingMaskIntoConstraints = false
    }

    // MARK: Boilerplate

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
