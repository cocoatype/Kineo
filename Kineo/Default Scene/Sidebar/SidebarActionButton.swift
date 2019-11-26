//  Created by Geoff Pado on 11/16/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import UIKit

class SidebarActionButton: UIControl {
    init(_ action: SidebarAction) {
        self.action = action
        super.init(frame: .zero)

        backgroundColor = .sidebarButtonBackground
        image = action.icon
        tintColor = .sidebarButtonTint
        translatesAutoresizingMaskIntoConstraints = false

        layer.cornerRadius = 8.0

        addTarget(action.target, action: action.selector, for: .primaryActionTriggered)
        if let doubleTapSelector = action.doubleTapSelector {
            addTarget(action.target, action: doubleTapSelector, for: .doubleTap)
        }

        addSubview(imageView)

        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalTo: heightAnchor),
            widthAnchor.constraint(equalToConstant: Self.width),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.widthAnchor.constraint(equalTo: widthAnchor),
            imageView.heightAnchor.constraint(equalTo: heightAnchor)
        ])

        addGestureRecognizer(singleTapGestureRecognizer)
        addGestureRecognizer(doubleTapGestureRecognizer )
    }

    private var action: SidebarAction

    // MARK: Icon Display

    private let imageView = SidebarActionButtonImageView()
    private var image: UIImage? {
        get { return imageView.image }
        set(newImage) { imageView.image = newImage }
    }

    // MARK: Touch Handling

    private lazy var singleTapGestureRecognizer: UITapGestureRecognizer = {
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleSingleTap))
        gestureRecognizer.require(toFail: doubleTapGestureRecognizer)
        return gestureRecognizer
    }()

    private lazy var doubleTapGestureRecognizer: UITapGestureRecognizer = {
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap))
        gestureRecognizer.numberOfTapsRequired = 2
        return gestureRecognizer
    }()

    @objc private func handleSingleTap() {
        sendActions(for: .primaryActionTriggered)
    }

    @objc private func handleDoubleTap() {
        sendActions(for: .doubleTap)
    }

    // MARK: Boilerplate

    static let width = CGFloat(44)

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}

extension UIControl.Event {
    static let doubleTap = UIControl.Event(rawValue: 0x1000000)
}

class SidebarActionButtonImageView: UIImageView {
    init() {
        super.init(frame: .zero)
        backgroundColor = .clear
        contentMode = .center
        translatesAutoresizingMaskIntoConstraints = false
    }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
