//  Created by Geoff Pado on 12/24/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import UIKit

class FilmStripExistingPageCell: UICollectionViewCell {
    static let identifier = "FilmStripExistingPageCell.identifier"

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .canvasBackground
        layer.cornerRadius = 8

        contentView.addSubview(imageView)

        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            imageView.heightAnchor.constraint(equalTo: contentView.heightAnchor),
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }

    var image: UIImage? {
        get { return imageView.image }
        set(newImage) { imageView.image = newImage }
    }

    // MARK: Boilerplate

    private let imageView = FilmStripExistingPageImageView()

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
