//  Created by Geoff Pado on 11/16/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import UIKit

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
