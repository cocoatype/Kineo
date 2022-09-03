//  Created by Geoff Pado on 9/5/21.
//  Copyright © 2021 Cocoatype, LLC. All rights reserved.

import UIKit

class CompactEditingViewButtonBar: UIView {
    init(statePublisher: EditingStatePublisher) {
        self.undoButton = UndoButton(statePublisher: statePublisher)
        self.redoButton = RedoButton(statePublisher: statePublisher)
        self.toolsButton = ToolsButton(statePublisher: statePublisher)
        super.init(frame: .zero)

        #if CLIP
        [menuButton, toolsButton, undoButton, redoButton].forEach(self.addSubview(_:))
        #else
        [galleryButton, menuButton, toolsButton, undoButton, redoButton].forEach(self.addSubview(_:))
        #endif
        addLayoutGuide(centerLayoutGuide)

        translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            centerLayoutGuide.topAnchor.constraint(equalTo: topAnchor),
            centerLayoutGuide.bottomAnchor.constraint(equalTo: bottomAnchor),
            centerLayoutGuide.centerXAnchor.constraint(equalTo: centerXAnchor),

            undoButton.leadingAnchor.constraint(equalTo: centerLayoutGuide.leadingAnchor),
            undoButton.centerYAnchor.constraint(equalTo: centerLayoutGuide.centerYAnchor),

            redoButton.leadingAnchor.constraint(equalTo: undoButton.trailingAnchor, constant: 11),
            redoButton.centerYAnchor.constraint(equalTo: centerLayoutGuide.centerYAnchor),

            toolsButton.leadingAnchor.constraint(equalTo: redoButton.trailingAnchor, constant: 11),
            toolsButton.centerYAnchor.constraint(equalTo: centerLayoutGuide.centerYAnchor),
            toolsButton.trailingAnchor.constraint(equalTo: centerLayoutGuide.trailingAnchor),

            menuButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            menuButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            menuButton.topAnchor.constraint(equalTo: topAnchor),
        ])

        #if !CLIP
        NSLayoutConstraint.activate([
            galleryButton.topAnchor.constraint(equalTo: topAnchor),
            galleryButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            galleryButton.leadingAnchor.constraint(equalTo: leadingAnchor),
        ])
        #endif
    }

    override var intrinsicContentSize: CGSize {
        CGSize(width: UIView.noIntrinsicMetric, height: SidebarActionButton.width)
    }

    // MARK: Boilerplate

    #if !CLIP
    private let galleryButton = GalleryButton()
    #endif
    private let menuButton = MenuButton()
    private let toolsButton: ToolsButton
    private let undoButton: UndoButton
    private let redoButton: RedoButton
    private let centerLayoutGuide = UILayoutGuide()

    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("\(String(describing: type(of: Self.self))) does not implement init(coder:)")
    }
}
