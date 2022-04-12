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
    private let zoomContentView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.isOpaque = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    required init(statePublisher: EditingStatePublisher, drawingViewController: DrawingViewController) {
        self.drawingViewController = drawingViewController
        self.statePublisher = statePublisher
        self.toolPicker = EditingToolPicker(statePublisher: statePublisher, drawingView: drawingViewController.drawingView)
        super.init(frame: .zero)

        backgroundColor = .appBackground

        zoomView.delegate = self
        zoomView.addSubview(zoomContentView)
        zoomView.addLayoutGuide(drawingViewGuide)

        #if CLIP
        [zoomView, filmStripView, backgroundButton, playButton, exportButton, playbackView].forEach(self.addSubview(_:))
        #else
        [zoomView, filmStripView, backgroundButton, playButton, galleryButton, exportButton, playbackView].forEach(self.addSubview(_:))
        #endif

        NSLayoutConstraint.activate([
            zoomView.widthAnchor.constraint(equalTo: widthAnchor),
            zoomView.heightAnchor.constraint(equalTo: heightAnchor),
            zoomView.centerXAnchor.constraint(equalTo: centerXAnchor),
            zoomView.centerYAnchor.constraint(equalTo: centerYAnchor),

            drawingViewGuide.centerXAnchor.constraint(equalTo: zoomView.contentLayoutGuide.centerXAnchor),
            drawingViewGuide.centerYAnchor.constraint(equalTo: zoomView.contentLayoutGuide.centerYAnchor),
//            drawingViewGuide.widthAnchor.constraint(equalTo: zoomView.contentLayoutGuide.widthAnchor),
//            drawingViewGuide.heightAnchor.constraint(equalTo: zoomView.contentLayoutGuide.heightAnchor),

            drawingViewGuide.widthAnchor.constraint(equalTo: drawingViewGuide.heightAnchor),
            drawingViewGuide.widthAnchor.constraint(equalToConstant: 512.0),
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

    // MARK: Scroll View Delegate

    // see also https://stackoverflow.com/a/19597755 for zooming from center
    func viewForZooming(in scrollView: UIScrollView) -> UIView? { drawingView }
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {}

//    func scrollViewDidZoom(_ scrollView: UIScrollView) {
////        guard let image = image else { return }
//        let zoomedImageSize = drawingView.bounds.size * scrollView.zoomScale //image.size * image.scale * zoomScale
//        let scrollSize = scrollView.bounds.size
//
//        let widthPadding = max(scrollSize.width - zoomedImageSize.width, 0) / 2
//        let heightPadding = max(scrollSize.height - zoomedImageSize.height, 0) / 2
//
//        print("BEFORE:")
//        print("zoomed image size: \(zoomedImageSize)")
//        print("scroll size: \(scrollSize)")
//        print("padding: {\(widthPadding), \(heightPadding)}")
//        print("content inset: \(scrollView.contentInset)")
//
//        scrollView.contentInset = UIEdgeInsets(top: 800, left: 800, bottom: 800, right: 800)
//
//        print("AFTER:")
//        print("zoomed image size: \(zoomedImageSize)")
//        print("scroll size: \(scrollSize)")
//        print("padding: {\(widthPadding), \(heightPadding)}")
//        print("content inset: \(scrollView.contentInset)")
//        print("=============")
////        delegate?.scrollViewDidZoom?(self)
//    }

//    func scrollViewDidZoom(_ scrollView: UIScrollView) {
//
//    }

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

/*
 photoScrollView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor),
 photoScrollView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor),
 photoScrollView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
 photoScrollView.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor)

 workspaceView.centerXAnchor.constraint(equalTo: contentLayoutGuide.centerXAnchor),
 workspaceView.centerYAnchor.constraint(equalTo: contentLayoutGuide.centerYAnchor),
 workspaceView.widthAnchor.constraint(equalTo: contentLayoutGuide.widthAnchor),
 workspaceView.heightAnchor.constraint(equalTo: contentLayoutGuide.heightAnchor)
 */
