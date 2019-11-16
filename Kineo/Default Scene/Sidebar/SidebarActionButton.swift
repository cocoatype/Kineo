//  Created by Geoff Pado on 11/16/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import UIKit

class SidebarActionButton: UIButton {
    init(_ action: SidebarAction) {
        self.action = action
        super.init(frame: .zero)

        backgroundColor = .clear
        tintColor = .newCellTint
        translatesAutoresizingMaskIntoConstraints = false

        setImage(action.icon, for: .normal)
        addTarget(action.target, action: action.selector, for: .primaryActionTriggered)

        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalTo: heightAnchor),
            widthAnchor.constraint(equalToConstant: Self.width)
        ])
    }

    private var action: SidebarAction

    // MARK: Boilerplate

    static let width = CGFloat(44)

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
