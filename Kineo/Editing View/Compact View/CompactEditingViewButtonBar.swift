//  Created by Geoff Pado on 9/5/21.
//  Copyright © 2021 Cocoatype, LLC. All rights reserved.

import UIKit

class CompactEditingViewButtonBar: UIView {
    init(statePublisher: EditingStatePublisher) {
        self.undoButton = UndoButton(statePublisher: statePublisher)
        self.redoButton = RedoButton(statePublisher: statePublisher)
        super.init(frame: .zero)

        [galleryButton, exportButton, toolsButton, undoButton, redoButton].forEach(self.addSubview(_:))

        translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            galleryButton.topAnchor.constraint(equalTo: topAnchor),
            galleryButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            exportButton.centerYAnchor.constraint(equalTo: galleryButton.centerYAnchor),
            exportButton.leadingAnchor.constraint(equalTo: galleryButton.trailingAnchor, constant: 11),
            toolsButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            toolsButton.topAnchor.constraint(equalTo: topAnchor),
            redoButton.trailingAnchor.constraint(equalTo: toolsButton.leadingAnchor, constant: -11),
            redoButton.centerYAnchor.constraint(equalTo: toolsButton.centerYAnchor),
            undoButton.trailingAnchor.constraint(equalTo: redoButton.leadingAnchor, constant: -11),
            undoButton.centerYAnchor.constraint(equalTo: toolsButton.centerYAnchor)
        ])
    }

    override var intrinsicContentSize: CGSize {
        CGSize(width: UIView.noIntrinsicMetric, height: SidebarActionButton.width)
    }

    // MARK: Boilerplate

    private let galleryButton = GalleryButton()
    private let exportButton = ExportButton()
    private let toolsButton = ToolsButton()
    private let undoButton: UndoButton
    private let redoButton: RedoButton

    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("\(String(describing: type(of: Self.self))) does not implement init(coder:)")
    }
}
