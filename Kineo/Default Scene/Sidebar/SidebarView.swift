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

    // MARK: Displaying Actions

    func display(_ actionSet: SidebarActionSet) {
        subviews.forEach { $0.removeFromSuperview() }
        let stackViews = (SidebarActionStackView(actionSet.0), SidebarActionStackView(actionSet.1), SidebarActionStackView(actionSet.2))

        addSubview(stackViews.0)
        addSubview(stackViews.1)
        addSubview(stackViews.2)

        NSLayoutConstraint.activate([
            stackViews.0.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackViews.0.widthAnchor.constraint(equalToConstant: SidebarActionButton.width),
            stackViews.0.topAnchor.constraint(equalTo: topAnchor, constant: 11),
            stackViews.1.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackViews.1.widthAnchor.constraint(equalToConstant: SidebarActionButton.width),
            stackViews.1.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackViews.2.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackViews.2.widthAnchor.constraint(equalToConstant: SidebarActionButton.width),
            stackViews.2.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -11)
        ])
    }

    // MARK: Boilerplate

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}

class SidebarActionButton: UIButton {
    init(_ action: SidebarAction) {
        self.action = action
        super.init(frame: .zero)

        backgroundColor = .clear
        tintColor = .newCellTint
        translatesAutoresizingMaskIntoConstraints = false

        setImage(action.icon, for: .normal)
//        imageView?.image = action.icon
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

class SidebarActionStackView: UIStackView {
    init(_ actions: [SidebarAction]) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false

        actions.map(SidebarActionButton.init).forEach(addArrangedSubview(_:))
    }

    // MARK: Boilerplate

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
