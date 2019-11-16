//  Created by Geoff Pado on 11/16/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import UIKit

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
