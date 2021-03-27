//  Created by Geoff Pado on 3/24/21.
//  Copyright © 2021 Cocoatype, LLC. All rights reserved.

import UIKit

class ExportEditingPickerControl: UIControl {
    var selectedIndex: Int = 0 {
        didSet {
            guard selectedIndex != oldValue else { return }
            sendActions(for: .valueChanged)
        }
    }

    init(images: [UIImage?]) {
        self.images = images
        super.init(frame: .zero)

        backgroundColor = .darkSystemBackgroundSecondary
        translatesAutoresizingMaskIntoConstraints = false

        layer.cornerRadius = intrinsicContentSize.height / 2
        layer.masksToBounds = true

        layer.addSublayer(backgroundLayer)
        layer.addSublayer(foregroundLayer)
        foregroundLayer.mask = maskLayer
    }

    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)

        backgroundLayer.frame = layer.bounds
        backgroundLayer.contents = IconsImageGenerator.background.image(from: images, bounds: bounds).cgImage

        foregroundLayer.frame = layer.bounds
        foregroundLayer.contents = IconsImageGenerator.foreground.image(from: images, bounds: bounds).cgImage

        maskLayer.frame = CGRect(center: imageCenters[selectedIndex], size: Self.thumbSize)
        maskLayer.path = UIBezierPath(ovalIn: CGRect(origin: .zero, size: Self.thumbSize)).cgPath
    }

    private lazy var imageCenters: [CGPoint] = {
        images.enumerated().map { [unowned self] (offset, _) -> CGPoint in
            IconsImagePositioning.rect(forImageAtIndex: offset, in: images, bounds: bounds).center
        }
    }()

    // MARK: Touch Handling
    private var trackedTouch: UITouch?

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard trackedTouch == nil else { return }
        trackedTouch = touches.first(where: { touch in
            let position = touch.location(in: self)
            return maskLayer.frame.contains(position)
        })
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let trackedTouch = trackedTouch, touches.contains(trackedTouch) else { return }

        CATransaction.begin()
        CATransaction.setDisableActions(true)
        let inset = Self.thumbSize.width / 2
        let insetBounds = bounds.inset(by: UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset))
        let proposedX = trackedTouch.location(in: self).x
        maskLayer.position.x = min(max(proposedX, insetBounds.minX), insetBounds.maxX)
        CATransaction.commit()
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let trackedTouch = trackedTouch, touches.contains(trackedTouch) else { return }
        self.trackedTouch = nil

        // find closest center to touch
        let position = trackedTouch.location(in: self)
        let closestCenterIndex = imageCenters.enumerated().reduce((Int.max, CGFloat.greatestFiniteMagnitude)) { (closestCenterTuple, nextCenterTuple) -> (Int, CGFloat) in
            let (index, nextCenter) = nextCenterTuple
            let (_, minDistance) = closestCenterTuple
            let distance = abs(nextCenter.x - position.x)
            if distance < minDistance { return (index, distance) }
            return closestCenterTuple
        }.0

        // set index based on center
        self.selectedIndex = closestCenterIndex

        // reposition thumb to index
        resetThumb()
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let trackedTouch = trackedTouch, touches.contains(trackedTouch) else { return }
        self.trackedTouch = nil

        resetThumb()
    }

    private func resetThumb() {
        let thumbCenter = imageCenters[selectedIndex]
        maskLayer.position = thumbCenter
    }

    // MARK: Boilerplate

    private static let thumbSize = CGSize(width: 36, height: 36)

    private let images: [UIImage?]

    private let backgroundLayer = CALayer()
    private let foregroundLayer = CALayer()
    private let maskLayer = CAShapeLayer()

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}

struct IconsImageGenerator {
    static let background = IconsImageGenerator(backgroundColor: .clear, foregroundColor: .white)
    static let foreground = IconsImageGenerator(backgroundColor: .white, foregroundColor: .black)

    private init(backgroundColor: UIColor, foregroundColor: UIColor) {
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
    }

    func image(from subimages: [UIImage?], bounds: CGRect) -> UIImage {
        return UIGraphicsImageRenderer(bounds: bounds).image { context in
            backgroundColor.setFill()
            context.fill(bounds)

            subimages.enumerated().forEach { (offset, element) in
                guard let image = element?.withTintColor(foregroundColor) else { return }
                UIGraphicsPushContext(context.cgContext)
                defer { UIGraphicsPopContext() }

                let rect = IconsImagePositioning.rect(forImageAtIndex: offset, in: subimages, bounds: bounds)
                image.draw(in: rect)
            }
        }
    }

    private let backgroundColor: UIColor
    private let foregroundColor: UIColor
}

enum IconsImagePositioning {
    static func rect(forImageAtIndex index: Int, in images: [UIImage?], bounds: CGRect) -> CGRect {
        guard let image = images[index] else { return .zero }
        let fullWidth = bounds.width
        let sumWidths = { (totalWidth: CGFloat, image: UIImage?) -> CGFloat in
            guard let image = image else { return totalWidth }
            return totalWidth + image.size.width
        }
        let imagesWidth = images.reduce(0, sumWidths)
        let remainingWidth = fullWidth - imagesWidth
        let spacing = remainingWidth / CGFloat(images.count + 1)

        let horizontalMargin = (spacing * CGFloat(index + 1)) + images.prefix(upTo: index).reduce(0, sumWidths)
        let verticalMargin = (bounds.height - image.size.height) / 2
        return CGRect(x: horizontalMargin, y: verticalMargin, width: image.size.width, height: image.size.height)
    }
}
