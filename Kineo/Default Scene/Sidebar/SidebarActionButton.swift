//  Created by Geoff Pado on 11/16/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import UIKit

class SidebarActionButton: UIControl, UIPointerInteractionDelegate {
    init(icon: UIImage? = nil, auxiliaryIcon: UIImage? = nil, selector: Selector, target: Any? = nil) {
        super.init(frame: .zero)

        backgroundColor = .sidebarButtonBackground
        image = icon
        auxiliaryImage = auxiliaryIcon
        tintColor = .sidebarButtonTint
        translatesAutoresizingMaskIntoConstraints = false
        isAccessibilityElement = true
        accessibilityTraits = [.button]

        clipsToBounds = false
        layer.masksToBounds = false
        layer.cornerRadius = Self.cornerRadius

        addTarget(target, action: selector, for: .touchUpInside)

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

        addPointerInteraction()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        auxiliaryImageView.frame = CGRect(x: bounds.maxX - 8, y: bounds.minY - 8, width: 16, height: 16) // constraints are being weird…
    }

    override var isHighlighted: Bool {
        didSet {
            setNeedsDisplay()
        }
    }

    override var isEnabled: Bool {
        didSet {
            alpha = isEnabled ? 1.0 : 0.4
            accessibilityTraits = isEnabled ? [.button] : [.button, .notEnabled]
        }
    }

    private var buttonBackgroundColor: UIColor {
        if isHighlighted { return .sidebarButtonHighlight }
        return .sidebarButtonBackground
    }

    // MARK: Pointer Interactions

    private func addPointerInteraction() {
        guard #available(iOS 13.4, *) else { return }
        let interaction = UIPointerInteraction(delegate: self)
        addInteraction(interaction)
    }

    @available(iOS 13.4, *)
    func pointerInteraction(_ interaction: UIPointerInteraction, regionFor request: UIPointerRegionRequest, defaultRegion: UIPointerRegion) -> UIPointerRegion? {
        return defaultRegion
    }

    @available(iOS 13.4, *)
    func pointerInteraction(_ interaction: UIPointerInteraction, styleFor region: UIPointerRegion) -> UIPointerStyle? {
        let targetedPreview = UITargetedPreview(view: self)
        let pointerStyle = UIPointerStyle(effect: .highlight(targetedPreview), shape: .roundedRect(frame, radius: Self.cornerRadius))
        return pointerStyle
    }

    // MARK: Icon Display

    private let imageView = SidebarActionButtonImageView()
    var image: UIImage? {
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

    // MARK: Boilerplate

    private static let cornerRadius = CGFloat(10)
    static let width = CGFloat(44)

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
