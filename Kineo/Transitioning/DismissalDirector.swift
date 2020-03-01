//  Created by Geoff Pado on 3/1/20.
//  Copyright © 2020 Cocoatype, LLC. All rights reserved.

import Data
import UIKit

class DismissalDirector: NSObject {
    func animateDismissal(from editingViewController: EditingViewController, to galleryViewController: GalleryViewController, in sceneViewController: SceneViewController) {
        guard let editingView = (editingViewController.view as? EditingView), let galleryView = galleryViewController.view else {
            assertionFailure("dismissal setup failure")
            sceneViewController.transition(to: galleryViewController)
            return
        }

        let canvasSnapshotSize = editingView.drawingView.bounds.size
        let canvasSnapshotImage = UIGraphicsImageRenderer(size: canvasSnapshotSize).image { context in
            let rect = CGRect(origin: .zero, size: canvasSnapshotSize)
            editingView.drawingView.drawHierarchy(in: rect, afterScreenUpdates: true)
        }

        let canvasSnapshot = CALayer()
        canvasSnapshot.backgroundColor = UIColor.canvasBackground.cgColor
        canvasSnapshot.contents = canvasSnapshotImage.cgImage
        canvasSnapshot.cornerRadius = 8
        canvasSnapshot.frame = editingView.drawingView.frame

        editingViewController.willMove(toParent: nil)
        sceneViewController.addChild(galleryViewController)

        galleryView.translatesAutoresizingMaskIntoConstraints = true
        galleryView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        galleryView.frame = sceneViewController.view.bounds

        CATransaction.begin()
        CATransaction.setDisableActions(true)
        CATransaction.setCompletionBlock { [weak galleryViewController, weak editingViewController, weak sceneViewController, weak canvasSnapshot] in
            guard let galleryViewController = galleryViewController, let editingViewController = editingViewController, let sceneViewController = sceneViewController, let canvasSnapshot = canvasSnapshot else { return }
            self.performDismissalAnimation(from: editingViewController, to: galleryViewController, in: sceneViewController, with: canvasSnapshot)
        }
        // add the snapshot view
        sceneViewController.view.layer.addSublayer(canvasSnapshot)

        // hide the editing view's drawing view
        editingView.drawingView.isHidden = true

        // add the editing view and lay out
        sceneViewController.view.insertSubview(galleryView, belowSubview: editingView)
        editingView.setNeedsLayout()
        editingView.layoutIfNeeded()
        CATransaction.commit()
    }

    private func performDismissalAnimation(from editingViewController: EditingViewController, to galleryViewController: GalleryViewController, in sceneViewController: SceneViewController, with canvasSnapshot: CALayer) {
        guard let documentCell = galleryViewController.cell(for: editingViewController.document) else { return }
        let cellSnapshotSize = documentCell.bounds.size
        let cellSnapshotImage = UIGraphicsImageRenderer(size: cellSnapshotSize).image { context in
            let rect = CGRect(origin: .zero, size: cellSnapshotSize)
            documentCell.drawHierarchy(in: rect, afterScreenUpdates: true)
        }

        CATransaction.begin()
        CATransaction.setAnimationDuration(0.35)
        CATransaction.setAnimationTimingFunction(CAMediaTimingFunction(name: .easeInEaseOut))
        CATransaction.setCompletionBlock { [weak galleryViewController, weak editingViewController, weak sceneViewController, weak canvasSnapshot] in
            guard let galleryViewController = galleryViewController, let editingViewController = editingViewController, let sceneViewController = sceneViewController, let canvasSnapshot = canvasSnapshot else { return }
            self.cleanupDismissalAnimation(from: editingViewController, to: galleryViewController, in: sceneViewController, with: canvasSnapshot)
        }

        // animate snapshot frame from current to drawing frame
        let snapshotFrame = canvasSnapshot.frame
        canvasSnapshot.frame = documentCell.frame
        canvasSnapshot.add(FrameAnimation(from: snapshotFrame, to: documentCell.frame), forKey: "snapshotFrame")

        let currentContents = canvasSnapshot.contents
        let newContents = cellSnapshotImage.cgImage
        canvasSnapshot.contents = newContents
        canvasSnapshot.add(ContentsAnimation(from: currentContents, to: newContents), forKey: "skinsImage")

        // fade in editing view
        editingViewController.view?.layer.opacity = 0
        editingViewController.view?.layer.add(OpacityAnimation(from: 1, to: 0), forKey: "editingOpacity")

        CATransaction.commit()
    }

    private func cleanupDismissalAnimation(from editingViewController: EditingViewController, to galleryViewController: GalleryViewController, in sceneViewController: SceneViewController, with canvasSnapshot: CALayer) {
        CATransaction.begin()
        CATransaction.setAnimationDuration(0.05)
        CATransaction.setAnimationTimingFunction(CAMediaTimingFunction(name: .easeOut))
        CATransaction.setCompletionBlock { [weak galleryViewController, weak editingViewController, weak sceneViewController, weak canvasSnapshot] in
            guard let galleryViewController = galleryViewController, let editingViewController = editingViewController, let sceneViewController = sceneViewController, let canvasSnapshot = canvasSnapshot else { return }
            canvasSnapshot.removeFromSuperlayer()
            editingViewController.view.removeFromSuperview()
            editingViewController.removeFromParent()
            galleryViewController.didMove(toParent: sceneViewController)
        }

        canvasSnapshot.opacity = 0
        CATransaction.commit()
    }
}
