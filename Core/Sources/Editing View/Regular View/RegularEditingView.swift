//  Created by Geoff Pado on 9/29/21.
//  Copyright © 2021 Cocoatype, LLC. All rights reserved.

import CanvasPhone
import DataPhone
import EditingStatePhone
import PencilKit
import StylePhone
import UIKit

class RegularEditingView: EditingDrawView, CanvasDisplayingView, UIScrollViewDelegate {
    var drawingFrame: CGRect { drawingView.frame }
    var drawingSuperview: UIView { zoomContentView }
    var drawingView: DrawingView { drawingViewController.drawingView }
    let drawingViewGuide = DrawingViewGuide()

    var filmStripView: UIView { filmStripViewController.view }
    var filmStripViewGuide = FilmStripViewGuide()

    var backgroundPopoverSourceView: UIView? { backgroundButton }

    required init(statePublisher: EditingStatePublisher, drawingViewController: DrawingViewController, filmStripViewController: UIViewController) {
        self.drawingViewController = drawingViewController
        self.filmStripViewController = filmStripViewController
        self.statePublisher = statePublisher
        self.toolPicker = EditingToolPicker(statePublisher: statePublisher, drawingView: drawingViewController.drawingView)
        super.init(frame: .zero)

        autoresizingMask = [.flexibleWidth, .flexibleHeight]
        backgroundColor = Asset.background.color

        zoomView.delegate = self
        zoomView.addSubview(zoomContentView)
        zoomContentView.addLayoutGuide(drawingViewGuide)
        addLayoutGuide(filmStripViewGuide)

        [zoomView, backgroundButton, playButton, galleryButton, displayModeButton, exportButton, playbackView].forEach(self.addSubview(_:))

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

            filmStripViewGuide.bottomAnchor.constraint(equalTo: playButton.topAnchor, constant: -11),
            filmStripViewGuide.widthAnchor.constraint(equalToConstant: 44),
            filmStripViewGuide.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 11),
            exportButton.topAnchor.constraint(equalTo: topAnchor, constant: 11),
            exportButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -11),
            backgroundButton.trailingAnchor.constraint(equalTo: exportButton.leadingAnchor, constant: -11),
            backgroundButton.centerYAnchor.constraint(equalTo: exportButton.centerYAnchor),
            playButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -11),
            playButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 11),
            playbackView.heightAnchor.constraint(equalTo: drawingViewGuide.heightAnchor),
            playbackView.widthAnchor.constraint(equalTo: drawingViewGuide.widthAnchor),
            playbackView.centerXAnchor.constraint(equalTo: drawingViewGuide.centerXAnchor),
            playbackView.centerYAnchor.constraint(equalTo: drawingViewGuide.centerYAnchor),
            filmStripViewGuide.topAnchor.constraint(equalTo: galleryButton.bottomAnchor, constant: 11),
            galleryButton.topAnchor.constraint(equalTo: topAnchor, constant: 11),
            galleryButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 11),
            displayModeButton.topAnchor.constraint(equalTo: galleryButton.topAnchor),
            displayModeButton.leadingAnchor.constraint(equalTo: galleryButton.trailingAnchor, constant: 11),
        ])
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

    private var controls: [UIView] {
        [filmStripView, backgroundButton, playButton, galleryButton, displayModeButton, exportButton]
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
    func scrollViewDidZoom(_ scrollView: UIScrollView) { updateButtonHidingState() }
    func scrollViewDidScroll(_ scrollView: UIScrollView) { updateButtonHidingState() }

    func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
        drawingView.startZooming()
    }

    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        drawingView.zoomScale = scale

        if (abs(scale - 1.0) < 0.001) {
            unzoomContinuation?.resume()
            unzoomContinuation = nil
        }

        if AppPurchaseStateObserver.shared.isPurchased == false {
            Task {
                await unzoom()
                _ = UIApplication.shared.sendAction(#selector(EditingDrawViewController.displayZoomPurchaseAlert(_:)), to: nil, from: self, for: nil)
            }
        }
    }

    var unzoomContinuation: CheckedContinuation<Void, Never>?
    func unzoom() async {
        guard abs(zoomView.zoomScale - 1.0) > 0.001 else { return }

        return await withCheckedContinuation { [weak self] continuation in
            self?.unzoomContinuation = continuation
            self?.zoomView.setZoomScale(1.0, animated: true)
        }
    }

#if !CLIP
    @objc func showGallery() {
        Task {
            await unzoom()
            chain(selector: #selector(SceneActions.showGallery), object: nil, ignoreSelf: true)
        }
    }
#endif

    // MARK: Canvas

    var canvasView: UIView { drawingView }

    // MARK: Boilerplate

    private let drawingViewController: DrawingViewController
    private let filmStripViewController: UIViewController
    private let statePublisher: EditingStatePublisher
    private let toolPicker: EditingToolPicker

    private let backgroundButton = BackgroundButton()
    private let playButton = PlayButton()
    private let galleryButton = GalleryButton()
    private let displayModeButton = DisplayModeButton()
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
