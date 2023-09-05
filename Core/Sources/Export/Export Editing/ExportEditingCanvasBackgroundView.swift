//  Created by Geoff Pado on 5/23/22.
//  Copyright © 2022 Cocoatype, LLC. All rights reserved.

import CanvasPhone
import DataPhone
import UIKit

class ExportEditingCanvasBackgroundView: UIView {
    init(document: Document) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false

        if let data = document.backgroundImageData,
           let backgroundImage = UIImage(data: data) {
            backgroundImageView.image = backgroundImage
        }

        backgroundImageView.backgroundColor = document.canvasBackgroundColor

        addSubview(backgroundView)
        addSubview(backgroundImageView)

        NSLayoutConstraint.activate([
            backgroundView.widthAnchor.constraint(equalTo: widthAnchor),
            backgroundView.heightAnchor.constraint(equalTo: heightAnchor),
            backgroundView.centerXAnchor.constraint(equalTo: centerXAnchor),
            backgroundView.centerYAnchor.constraint(equalTo: centerYAnchor),
            backgroundImageView.widthAnchor.constraint(equalTo: widthAnchor),
            backgroundImageView.heightAnchor.constraint(equalTo: heightAnchor),
            backgroundImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            backgroundImageView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    private let backgroundView = DrawingBackgroundView()
    private let backgroundImageView = BackgroundImageView()

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
