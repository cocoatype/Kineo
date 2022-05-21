//  Created by Geoff Pado on 9/29/21.
//  Copyright © 2021 Cocoatype, LLC. All rights reserved.

import Data
import PencilKit
import UIKit

class RegularEditingView: EditingView, UIScrollViewDelegate {
    var drawingFrame: CGRect { drawingView.frame }
    var drawingSuperview: UIView { zoomContentView }
    var drawingView: DrawingView { drawingViewController.drawingView }
    let drawingViewGuide = DrawingViewGuide()

    var backgroundPopoverSourceView: UIView? { backgroundButton }

    required init(statePublisher: EditingStatePublisher, drawingViewController: DrawingViewController) {
        self.drawingViewController = drawingViewController
        self.statePublisher = statePublisher
        self.toolPicker = EditingToolPicker(statePublisher: statePublisher, drawingView: drawingViewController.drawingView)
        super.init(frame: .zero)

        backgroundColor = .appBackground

        zoomView.delegate = self
        zoomView.addSubview(zoomContentView)
        zoomContentView.addLayoutGuide(drawingViewGuide)

        #if CLIP
        [zoomView, filmStripView, backgroundButton, playButton, exportButton, playbackView].forEach(self.addSubview(_:))
        #else
        [zoomView, filmStripView, backgroundButton, playButton, galleryButton, exportButton, playbackView].forEach(self.addSubview(_:))
        #endif

        NSLayoutConstraint.activate([
            zoomView.frameLayoutGuide.widthAnchor.constraint(equalTo: widthAnchor),
            zoomView.frameLayoutGuide.heightAnchor.constraint(equalTo: heightAnchor),
            zoomView.frameLayoutGuide.centerXAnchor.constraint(equalTo: centerXAnchor),
            zoomView.frameLayoutGuide.centerYAnchor.constraint(equalTo: centerYAnchor),

            zoomView.contentLayoutGuide.widthAnchor.constraint(equalTo: widthAnchor),
            zoomView.contentLayoutGuide.heightAnchor.constraint(equalTo: heightAnchor),
            zoomView.contentLayoutGuide.centerXAnchor.constraint(equalTo: centerXAnchor),
            zoomView.contentLayoutGuide.centerYAnchor.constraint(equalTo: centerYAnchor),

            drawingViewGuide.centerXAnchor.constraint(equalTo: zoomView.contentLayoutGuide.centerXAnchor),
            drawingViewGuide.centerYAnchor.constraint(equalTo: zoomView.contentLayoutGuide.centerYAnchor),

            drawingViewGuide.widthAnchor.constraint(equalTo: drawingViewGuide.heightAnchor),
            drawingViewGuide.widthAnchor.constraint(equalToConstant: 512.0),

            zoomContentView.widthAnchor.constraint(equalTo: zoomView.contentLayoutGuide.widthAnchor),
            zoomContentView.heightAnchor.constraint(equalTo: zoomView.contentLayoutGuide.heightAnchor),
            zoomContentView.centerXAnchor.constraint(equalTo: zoomView.contentLayoutGuide.centerXAnchor),
            zoomContentView.centerYAnchor.constraint(equalTo: zoomView.contentLayoutGuide.centerYAnchor),

            filmStripView.bottomAnchor.constraint(equalTo: playButton.topAnchor, constant: -11),
            filmStripView.widthAnchor.constraint(equalToConstant: 44),
            filmStripView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 11),
            exportButton.topAnchor.constraint(equalTo: topAnchor, constant: 11),
            exportButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -11),
            backgroundButton.trailingAnchor.constraint(equalTo: exportButton.leadingAnchor, constant: -11),
            backgroundButton.centerYAnchor.constraint(equalTo: exportButton.centerYAnchor),
            playButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -11),
            playButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 11),
            playbackView.heightAnchor.constraint(equalTo: drawingViewGuide.heightAnchor),
            playbackView.widthAnchor.constraint(equalTo: drawingViewGuide.widthAnchor),
            playbackView.centerXAnchor.constraint(equalTo: drawingViewGuide.centerXAnchor),
            playbackView.centerYAnchor.constraint(equalTo: drawingViewGuide.centerYAnchor)
        ])

        #if CLIP
        NSLayoutConstraint.activate([
            filmStripView.topAnchor.constraint(equalTo: topAnchor, constant: 11)
        ])
        #else
        NSLayoutConstraint.activate([
            filmStripView.topAnchor.constraint(equalTo: galleryButton.bottomAnchor, constant: 11),
            galleryButton.topAnchor.constraint(equalTo: topAnchor, constant: 11),
            galleryButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 11),
        ])
        #endif
    }

    // MARK: Hiding Buttons

    private var effectiveCanvasFrame: CGRect {
        let viewSize = drawingView.bounds.size * zoomView.zoomScale

        var origin = drawingView.frame.origin
        origin.x *= zoomView.zoomScale
        origin.y *= zoomView.zoomScale
        origin.x -= zoomView.contentOffset.x
        origin.y -= zoomView.contentOffset.y

        return CGRect(origin: origin, size: viewSize)
    }

    private var controls: [UIControl] {
        #if CLIP
        [filmStripView, backgroundButton, playButton, exportButton]
        #else
        [filmStripView, backgroundButton, playButton, galleryButton, exportButton]
        #endif
    }

    private var controlsAlpha: Float {
        get { return playButton.layer.opacity }
        set {
            CATransaction.begin()
            let alphaAnimation = CABasicAnimation(keyPath: "opacity")
            alphaAnimation.duration = 0.3
            alphaAnimation.fromValue = controlsAlpha
            alphaAnimation.toValue = newValue
            controls.forEach { $0.layer.add(alphaAnimation, forKey: "opacity")}
            CATransaction.commit()
            controls.forEach { $0.layer.opacity = newValue }
        }
    }

    private func updateButtonHidingState() {
        setNeedsDisplay()
        let controls = [filmStripView, backgroundButton, playButton, exportButton]
        let intersectsCanvas = controls.contains(where: { $0.frame.intersects(effectiveCanvasFrame) })
        if intersectsCanvas && controlsAlpha == 1 {
            controlsAlpha = 0
        } else if intersectsCanvas == false && controlsAlpha == 0 {
            controlsAlpha = 1
        }
    }

    // MARK: Scroll View

    func viewForZooming(in scrollView: UIScrollView) -> UIView? { zoomContentView }
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
//        drawingView.zoomScale = scrollView.zoomScale
        updateButtonHidingState() }
    func scrollViewDidScroll(_ scrollView: UIScrollView) { updateButtonHidingState() }

    func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
        drawingView.startZooming()
    }
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        print("finished zooming")
        drawingView.zoomScale = scale
        print("updated zoom scale")

        if (abs(scale - 1.0) < 0.001) {
            unzoomContinuation?.resume()
            unzoomContinuation = nil
        }

        if AppPurchaseStateObserver.shared.isPurchased == false {
            Task {
                await unzoom()
                UIApplication.shared.sendAction(#selector(EditingViewController.displayZoomPurchaseAlert(_:)), to: nil, from: self, for: nil)
            }
        }
    }

    var unzoomContinuation: CheckedContinuation<Void, Never>?
    func unzoom() async {
        guard abs(zoomView.zoomScale - 1.0) > 0.001 else { return }

        return await withCheckedContinuation { [weak self] continuation in
            self?.unzoomContinuation = continuation
            zoomView.setZoomScale(1.0, animated: true)
        }
    }

#if !CLIP
    @objc func showGallery() {
        Task {
            await unzoom()
            chain(selector: #selector(SceneViewController.showGallery), object: nil, ignoreSelf: true)
        }
    }
#endif

    // MARK: Boilerplate

    private let drawingViewController: DrawingViewController
    private let statePublisher: EditingStatePublisher
    private let toolPicker: EditingToolPicker

    private lazy var filmStripView = FilmStripView(statePublisher: statePublisher)
    private let backgroundButton = BackgroundButton()
    private let playButton = PlayButton()
    #if !CLIP
    private let galleryButton = GalleryButton()
    #endif
    private let exportButton = ExportButton()
    private lazy var playbackView = PlaybackView(statePublisher: statePublisher)
    private let zoomView = EditingZoomScrollView()
    private let zoomContentView = EditingZoomContentView()

    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("\(String(describing: type(of: Self.self))) does not implement init(coder:)")
    }
}

public extension CGSize {
    static func * (size: CGSize, multiplier: CGFloat) -> CGSize {
        return CGSize(width: size.width * multiplier, height: size.height * multiplier)
    }
}
