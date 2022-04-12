//  Created by Geoff Pado on 4/8/22.
//  Copyright © 2022 Cocoatype, LLC. All rights reserved.

import UIKit

class EditingZoomScrollView: UIScrollView {
    init() {
        super.init(frame: .zero)

        contentMode = .center

        contentInsetAdjustmentBehavior = .never
        maximumZoomScale = 4.0
        translatesAutoresizingMaskIntoConstraints = false

        panGestureRecognizer.minimumNumberOfTouches = 2

        NSLayoutConstraint.activate([
            contentLayoutGuide.widthAnchor.constraint(equalTo: widthAnchor),
            contentLayoutGuide.heightAnchor.constraint(equalTo: heightAnchor)
        ])
    }

//    override func layoutSubviews() {
//        super.layoutSubviews()
//        updateZoomScale()
//    }
//
//    private func updateZoomScale() {
//        guard let drawingView = drawingView else { return }
//        drawingView.canv
//        let oldMinimumZoomScale = minimumZoomScale
//        minimumZoomScale = minimumZoomScaleForCurrentImage
//
//        if zoomScale == oldMinimumZoomScale {
//            zoomScale = minimumZoomScaleForCurrentImage
//        }
//
//        updateScrollViewContentInsets()
//    }

//    private func updateScrollViewContentInsets() {
//        guard let drawingView = drawingView else { return }
//        let zoomedImageSize = drawingView.bounds.size * zoomScale
//        let scrollSize = bounds.size
//
//        let widthPadding = max(scrollSize.width - zoomedImageSize.width, 0) / -2
//        let heightPadding = max(scrollSize.height - zoomedImageSize.height, 0) / -2
//
////        print("content inset before: \(contentInset)")
//        contentInset = UIEdgeInsets(top: heightPadding, left: widthPadding, bottom: heightPadding, right: widthPadding)
////        contentOffset = .zero
//        delegate?.scrollViewDidZoom?(self)
////        print("content inset after: \(contentInset)")
//        drawingView.setNeedsLayout()
//    }

    var drawingView: DrawingView? {
        subviews.first(where: { $0 is DrawingView }) as? DrawingView
    }

    // MARK: Boilerplate

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
