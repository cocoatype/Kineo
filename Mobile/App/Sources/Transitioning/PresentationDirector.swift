//  Created by Geoff Pado on 2/29/20.
//  Copyright © 2020 Cocoatype, LLC. All rights reserved.

import Core
import DataPhone
import StylePhone
import UIKit

class PresentationDirector: NSObject {
    func animatePresentation(from galleryViewController: GalleryViewController, to editingViewController: EditingViewController, in sceneViewController: SceneViewController) {
        let document = editingViewController.document
        guard UIAccessibility.isReduceMotionEnabled == false else {
            return sceneViewController.transition(to: editingViewController)
        }
        guard let editingView = editingViewController.view,
              let selectedCell = galleryViewController.cell(for: document)
        else {
            sceneViewController.transition(to: editingViewController)
            return
        }

        let cellSnapshotSize = selectedCell.bounds.size
        let cellSnapshotImage = UIGraphicsImageRenderer(size: cellSnapshotSize).image { context in
            let rect = CGRect(origin: .zero, size: cellSnapshotSize)
            selectedCell.drawHierarchy(in: rect, afterScreenUpdates: true)
        }
        selectedCell.layer.opacity = 0

        let cellSnapshot = CALayer()
        cellSnapshot.backgroundColor = (document.structYourStuffBatman ?? Asset.canvasBackground.color).cgColor
        if selectedCell is GalleryDocumentCollectionViewCell {
            cellSnapshot.contents = cellSnapshotImage.cgImage
        }
        cellSnapshot.cornerRadius = 8
        cellSnapshot.frame = sceneViewController.view.convert(selectedCell.bounds, from: selectedCell)

        galleryViewController.willMove(toParent: nil)
        sceneViewController.addChild(editingViewController)

        editingView.translatesAutoresizingMaskIntoConstraints = true
        editingView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        editingView.frame = sceneViewController.view.bounds

        CATransaction.begin()
        CATransaction.setDisableActions(true)
        CATransaction.setCompletionBlock { [weak galleryViewController, weak editingViewController, weak sceneViewController, weak cellSnapshot] in
            guard let galleryViewController, let editingViewController, let sceneViewController, let cellSnapshot else { return }
            Task { @MainActor in
                await self.performPresentationAnimation(from: galleryViewController, to: editingViewController, in: sceneViewController, with: cellSnapshot)
            }
        }
        // hide the editing view's drawing view
        editingViewController.canvasDisplayView?.canvasView.isHidden = true

        // set the editing view's alpha to 0%
        editingView.layer.opacity = 0

        // add the editing view and lay out
        sceneViewController.view.addSubview(editingView)
        editingView.setNeedsLayout()
        editingView.layoutIfNeeded()

        // add the snapshot view
        sceneViewController.view.layer.addSublayer(cellSnapshot)
        CATransaction.commit()
    }

    @MainActor
    private func performPresentationAnimation(from galleryViewController: GalleryViewController, to editingViewController: EditingViewController, in sceneViewController: SceneViewController, with cellSnapshot: CALayer) async {
        guard let editingView = editingViewController.view,
              let drawView = editingViewController.canvasDisplayView
        else {
            return sceneViewController.transition(to: editingViewController)
        }

        let document = editingViewController.document

        let (skinsImage, _) = await DrawingImageGenerator.shared.generateFirstSkinLayer(for: document)
        // grab the drawing frame
        let drawingFrame = drawView.canvasView.frame

        CATransaction.begin()
        CATransaction.setAnimationDuration(0.35)
        CATransaction.setAnimationTimingFunction(CAMediaTimingFunction(name: .easeInEaseOut))
        CATransaction.setCompletionBlock { [weak galleryViewController, weak editingViewController, weak sceneViewController, weak cellSnapshot] in
            guard let galleryViewController = galleryViewController, let editingViewController = editingViewController, let sceneViewController = sceneViewController, let cellSnapshot = cellSnapshot else { return }
            self.cleanupPresentationAnimation(from: galleryViewController, to: editingViewController, in: sceneViewController, with: cellSnapshot)
        }

        // animate snapshot frame from current to drawing frame
        let snapshotFrame = cellSnapshot.frame
        cellSnapshot.frame = drawingFrame
        cellSnapshot.add(FrameAnimation(from: snapshotFrame, to: drawingFrame), forKey: "snapshotFrame")

        let currentContents = cellSnapshot.contents
        let newContents = skinsImage.cgImage
        cellSnapshot.contents = newContents
        cellSnapshot.add(ContentsAnimation(from: currentContents, to: newContents), forKey: "skinsImage")

        // fade in editing view
        editingView.layer.opacity = 1
        editingView.layer.add(OpacityAnimation(from: 0, to: 1), forKey: "editingOpacity")

        CATransaction.commit()
    }

    private func cleanupPresentationAnimation(from galleryViewController: GalleryViewController, to editingViewController: EditingViewController, in sceneViewController: SceneViewController, with cellSnapshot: CALayer) {
        guard let canvasDisplayView = editingViewController.canvasDisplayView else { return }
        canvasDisplayView.canvasView.isHidden = false

        CATransaction.begin()
        CATransaction.setAnimationDuration(0.05)
        CATransaction.setAnimationTimingFunction(CAMediaTimingFunction(name: .easeOut))
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
