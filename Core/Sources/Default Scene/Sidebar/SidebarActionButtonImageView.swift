//  Created by Geoff Pado on 11/25/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import StylePhone
import UIKit

class SidebarActionButtonImageView: UIImageView {
    init() {
        super.init(frame: .zero)
        backgroundColor = .clear
        contentMode = .center
        tintColor = Asset.sidebarButtonTint.color
        translatesAutoresizingMaskIntoConstraints = false
    }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}

class SidebarActionButtonAuxiliaryImageView: UIImageView {
    init() {
        super.init(frame: .zero)
        backgroundColor = Asset.sidebarButtonBackground.color
        contentMode = .center
        tintColor = Asset.sidebarButtonTint.color
        translatesAutoresizingMaskIntoConstraints = false

        let maskLayer = CAShapeLayer()
        let maskFrame = CGRect(origin: .zero, size: CGSize(width: 16, height: 16))
        maskLayer.frame = maskFrame
        maskLayer.path = UIBezierPath(ovalIn: maskFrame).cgPath
        layer.mask = maskLayer

        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: 16),
            heightAnchor.constraint(equalTo: widthAnchor)
        ])
    }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
