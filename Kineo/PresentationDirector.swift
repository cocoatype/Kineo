//  Created by Geoff Pado on 2/29/20.
//  Copyright © 2020 Cocoatype, LLC. All rights reserved.

import UIKit

class PresentationDirector: NSObject {
    func animatePresentation(from galleryViewController: GalleryViewController, to editingViewController: EditingViewController, in sceneViewController: SceneViewController) {
        guard
          let editingView = (editingViewController.view as? EditingView),
          let selectedCell = galleryViewController.cell(for: editingViewController.document)
//          let cellSnapshot = selectedCell.snapshotView(afterScreenUpdates: true)
        else {
            assertionFailure("transition setup failure")
            sceneViewController.transition(to: editingViewController)
            return
        }

        let cellSnapshotSize = selectedCell.bounds.size
        let cellSnapshotImage = UIGraphicsImageRenderer(size: cellSnapshotSize).image { context in
            let rect = CGRect(origin: .zero, size: cellSnapshotSize)
            selectedCell.drawHierarchy(in: rect, afterScreenUpdates: true)
        }

        let cellSnapshot = CALayer()
        cellSnapshot.contents = cellSnapshotImage.cgImage
        cellSnapshot.frame = selectedCell.frame

        galleryViewController.willMove(toParent: nil)
        sceneViewController.addChild(editingViewController)

        editingView.translatesAutoresizingMaskIntoConstraints = true
        editingView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        editingView.frame = sceneViewController.view.bounds

        CATransaction.begin()
        CATransaction.setDisableActions(true)
        CATransaction.setCompletionBlock { [weak galleryViewController, weak editingViewController, weak sceneViewController, weak cellSnapshot] in
            guard let galleryViewController = galleryViewController, let editingViewController = editingViewController, let sceneViewController = sceneViewController, let cellSnapshot = cellSnapshot else { return }
            self.performPresentationAnimation(from: galleryViewController, to: editingViewController, in: sceneViewController, with: cellSnapshot)
        }
        // hide the editing view's drawing view
        editingView.prepareForPresentation()

        // set the editing view's alpha to 0%
        editingView.layer.opacity = 0

        // add the editing view and lay out
        sceneViewController.view.addSubview(editingView)
        editingView.setNeedsLayout()
        editingView.layoutIfNeeded()

        // add the snapshot view
        sceneViewController.view.layer.addSublayer(cellSnapshot)
        CATransaction.commit()

        // clean up
    }

    private func performPresentationAnimation(from galleryViewController: GalleryViewController, to editingViewController: EditingViewController, in sceneViewController: SceneViewController, with cellSnapshot: CALayer) {
        guard let editingView = (editingViewController.view as? EditingView) else { return }

        // grab the drawing frame
        let drawingFrame = editingView.drawingFrame

        CATransaction.begin()
        CATransaction.setAnimationDuration(0.25)
        CATransaction.setCompletionBlock { [weak galleryViewController, weak editingViewController, weak sceneViewController, weak cellSnapshot] in
            guard let galleryViewController = galleryViewController, let editingViewController = editingViewController, let sceneViewController = sceneViewController, let cellSnapshot = cellSnapshot else { return }
            self.cleanupPresentationAnimation(from: galleryViewController, to: editingViewController, in: sceneViewController, with: cellSnapshot)
        }

        // animate snapshot frame from current to drawing frame
        let snapshotFrame = cellSnapshot.frame
        cellSnapshot.frame = drawingFrame
        cellSnapshot.add(FrameAnimation(from: snapshotFrame, to: drawingFrame), forKey: "snapshotFrame")

        // fade in editing view
        editingView.layer.opacity = 1
        editingView.layer.add(OpacityAnimation(from: 0, to: 1), forKey: "editingOpacity")

        CATransaction.commit()
    }

    private func cleanupPresentationAnimation(from galleryViewController: GalleryViewController, to editingViewController: EditingViewController, in sceneViewController: SceneViewController, with cellSnapshot: CALayer) {
        guard let editingView = (editingViewController.view as? EditingView) else { return }
        editingView.finalizePresentation()

        CATransaction.begin()
        CATransaction.setAnimationDuration(0.25)
        CATransaction.setCompletionBlock { [weak galleryViewController, weak editingViewController, weak sceneViewController, weak cellSnapshot] in
            guard let galleryViewController = galleryViewController, let editingViewController = editingViewController, let sceneViewController = sceneViewController, let cellSnapshot = cellSnapshot else { return }
            cellSnapshot.removeFromSuperlayer()
            galleryViewController.view.removeFromSuperview()
            galleryViewController.removeFromParent()
            editingViewController.didMove(toParent: sceneViewController)
        }

        cellSnapshot.opacity = 0
        CATransaction.commit()
    }
}

class FrameAnimation: CABasicAnimation {
    init(from: CGRect, to: CGRect) {
        super.init()
        keyPath = #keyPath(CALayer.frame)
        fromValue = from
        toValue = to
    }

    override init() { super.init() } // needed to not crash
    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}

class OpacityAnimation: CABasicAnimation {
    init(from: CGFloat, to: CGFloat) {
        super.init()
        keyPath = #keyPath(CALayer.opacity)
        fromValue = min(max(from, 0), 1)
        toValue = min(max(to, 0), 1)
    }

    override init() { super.init() } // needed to not crash
    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
