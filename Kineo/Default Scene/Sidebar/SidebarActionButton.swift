//  Created by Geoff Pado on 11/16/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import UIKit

class SidebarActionButton: UIControl {
    init(icon: UIImage? = nil, auxiliaryIcon: UIImage? = nil, selector: Selector, doubleTapSelector: Selector? = nil, target: Any? = nil) {
        super.init(frame: .zero)

        backgroundColor = .clear
        image = icon
        auxiliaryImage = auxiliaryIcon
        tintColor = .sidebarButtonTint
        translatesAutoresizingMaskIntoConstraints = false

        layer.masksToBounds = false
        clipsToBounds = false

        addTarget(target, action: selector, for: .primaryActionTriggered)
        if let doubleTapSelector = doubleTapSelector {
            addTarget(target, action: doubleTapSelector, for: .doubleTap)
        }

        addSubview(imageView)
        addSubview(auxiliaryImageView)

        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalTo: heightAnchor),
            widthAnchor.constraint(equalToConstant: Self.width),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.widthAnchor.constraint(equalTo: widthAnchor),
            imageView.heightAnchor.constraint(equalTo: heightAnchor),
            auxiliaryImageView.centerXAnchor.constraint(equalTo: trailingAnchor),
            auxiliaryImageView.centerYAnchor.constraint(equalTo: topAnchor)
        ])

        addGestureRecognizer(singleTapGestureRecognizer)
        addGestureRecognizer(doubleTapGestureRecognizer)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        auxiliaryImageView.frame = CGRect(x: bounds.maxX - 8, y: bounds.minY - 8, width: 16, height: 16) // constraints are being weird…
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        UIColor.sidebarButtonBackground.setFill()

        if auxiliaryImage != nil {
            let boundsPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: [.bottomLeft, .bottomRight, .topLeft], cornerRadii: CGSize(width: 10, height: 10))
            let cutoutRect = CGRect(x: bounds.maxX - 10, y: bounds.minY - 10, width: 20, height: 20)
            let cutoutPath = UIBezierPath(ovalIn: cutoutRect)
            boundsPath.append(cutoutPath.reversing())
            boundsPath.fill()
        } else {
            UIBezierPath(roundedRect: bounds, cornerRadius: 10).fill()
        }
    }

    // MARK: Icon Display

    private let imageView = SidebarActionButtonImageView()
    private var image: UIImage? {
        get { return imageView.image }
        set(newImage) { imageView.image = newImage }
    }

    private let auxiliaryImageView = SidebarActionButtonAuxiliaryImageView()
    private var auxiliaryImage: UIImage? {
        get { return auxiliaryImageView.image }
        set(newImage) {
            auxiliaryImageView.image = newImage
            auxiliaryImageView.isHidden = (newImage == nil)
        }
    }

    // MARK: Touch Handling

    private lazy var singleTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleSingleTap))

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
