//  Created by Geoff Pado on 4/18/21.
//  Copyright © 2021 Cocoatype, LLC. All rights reserved.

import UIKit

class ExportEditingPreviewWatermarkImageView: UIImageView {
    init() {
        super.init(frame: .zero)
        contentMode = .scaleAspectFill
        image = Self.watermarkImage
        translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalTo: heightAnchor, multiplier: Self.watermarkImage.size.width / Self.watermarkImage.size.height)
        ])
    }

    override var intrinsicContentSize: CGSize { Self.watermarkImage.size }

    // MARK: Boilerplate

    private static let watermarkImage: UIImage = {
        guard let image = UIImage(named: "Watermark") else { fatalError("Unable to load watermark image") }
        return image
    }()

    static let watermarkWidth = watermarkImage.size.width

    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("\(String(describing: type(of: Self.self))) does not implement init(coder:)")
    }
}
