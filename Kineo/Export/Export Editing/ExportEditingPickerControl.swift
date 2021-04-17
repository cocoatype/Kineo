//  Created by Geoff Pado on 3/24/21.
//  Copyright © 2021 Cocoatype, LLC. All rights reserved.

import UIKit

class ExportEditingPickerControl: UIControl {
    var selectedIndex: Int {
        didSet {
            guard selectedIndex != oldValue else { return }
            sendActions(for: .valueChanged)
            feedbackGenerator?.selectionChanged()
        }
    }

    init(images: [UIImage?], selectedIndex: Int) {
        self.images = images
        self.selectedIndex = selectedIndex
        super.init(frame: .zero)

        backgroundColor = .darkSystemBackgroundSecondary
        translatesAutoresizingMaskIntoConstraints = false

        layer.cornerRadius = intrinsicContentSize.height / 2
        layer.masksToBounds = true

        layer.addSublayer(backgroundLayer)
        layer.addSublayer(foregroundLayer)
        foregroundLayer.mask = maskLayer

        setContentCompressionResistancePriority(.required, for: .vertical)

        gestureRecognizer.addTarget(self, action: #selector(handleGesture))
        addGestureRecognizer(gestureRecognizer)
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

    private func moveThumb(to location: CGPoint, animated: Bool) {
        print("moving thumb")
        CATransaction.begin()
        defer { CATransaction.commit() }
        CATransaction.setDisableActions(animated == false)

        let inset = Self.thumbSize.width / 2
        let insetBounds = bounds.inset(by: UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset))
        let proposedX = location.x
        maskLayer.position.x = min(max(proposedX, insetBounds.minX), insetBounds.maxX)
    }

    private func updateIndex(for location: CGPoint) {
        // find closest center to touch
        let closestCenterIndex = imageCenters.enumerated().reduce((Int.max, CGFloat.greatestFiniteMagnitude)) { (closestCenterTuple, nextCenterTuple) -> (Int, CGFloat) in
            let (index, nextCenter) = nextCenterTuple
            let (_, minDistance) = closestCenterTuple
            let distance = abs(nextCenter.x - location.x)
            if distance < minDistance { return (index, distance) }
            return closestCenterTuple
        }.0

        // set index based on center
        self.selectedIndex = closestCenterIndex
    }

    private func resetThumb() {
        let thumbCenter = imageCenters[selectedIndex]
        maskLayer.position = thumbCenter
    }

    @objc private func handleGesture() {
        let location = gestureRecognizer.location(in: self)
        switch gestureRecognizer.state {
        case .began:
            feedbackGenerator = UISelectionFeedbackGenerator()
            feedbackGenerator?.prepare()
            moveThumb(to: location, animated: true)
        case .changed:
            moveThumb(to: location, animated: false)
            updateIndex(for: location)
        case .ended, .cancelled:
            resetThumb()
            fallthrough
        case .possible, .failed:
            fallthrough
        @unknown default:
            feedbackGenerator = nil
        }
    }

    // MARK: Boilerplate

    private static let thumbSize = CGSize(width: 36, height: 36)

    private let gestureRecognizer = ExportEditingPickerControlGestureRecognizer()
    private let images: [UIImage?]

    private let backgroundLayer = CALayer()
    private let foregroundLayer = CALayer()
    private let maskLayer = CAShapeLayer()

    private var feedbackGenerator: UISelectionFeedbackGenerator?

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
