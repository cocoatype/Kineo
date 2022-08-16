//  Created by Geoff Pado on 8/8/22.
//  Copyright © 2022 Cocoatype, LLC. All rights reserved.

import UIKit

class EditingPlayView: UIView, CanvasDisplayingView {
    init() {
        super.init(frame: .zero)
        backgroundColor = .appBackground

        addSubview(displayModeButton)
        addSubview(exportButton)
        addSubview(galleryButton)
        addSubview(juniorDevs)

        NSLayoutConstraint.activate([
            galleryButton.topAnchor.constraint(equalTo: topAnchor, constant: 11),
            galleryButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 11),
            displayModeButton.topAnchor.constraint(equalTo: galleryButton.topAnchor),
            displayModeButton.leadingAnchor.constraint(equalTo: galleryButton.trailingAnchor, constant: 11),
            exportButton.topAnchor.constraint(equalTo: topAnchor, constant: 11),
            exportButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -11),
            juniorDevs.centerXAnchor.constraint(equalTo: centerXAnchor),
            juniorDevs.centerYAnchor.constraint(equalTo: centerYAnchor),
            juniorDevs.widthAnchor.constraint(equalToConstant: 512),
            juniorDevs.heightAnchor.constraint(equalToConstant: 512)
        ])
    }

    var canvasView: UIView { return juniorDevs }

    // MARK: Boilerplate

    // juniorDevs by @eaglenaut on 8/8/22
    private let juniorDevs: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGreen
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let displayModeButton = DisplayModeButton(mode: .play)
    private let exportButton = ExportButton()
    private let galleryButton = GalleryButton()

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
