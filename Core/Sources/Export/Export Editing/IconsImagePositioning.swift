//  Created by Geoff Pado on 4/2/21.
//  Copyright © 2021 Cocoatype, LLC. All rights reserved.

import UIKit

enum IconsImagePositioning {
    static func rect(forImageAtIndex index: Int, in images: [UIImage?], bounds: CGRect) -> CGRect {
        guard let image = images[index] else { return .zero }
        let fullWidth = bounds.width
        let sumWidths = { (totalWidth: CGFloat, image: UIImage?) -> CGFloat in
            guard let image = image else { return totalWidth }
            return totalWidth + image.size.width
        }
        let imagesWidth = images.reduce(0, sumWidths)
        let remainingWidth = fullWidth - imagesWidth
        let spacing = remainingWidth / CGFloat(images.count + 1)

        let horizontalMargin = (spacing * CGFloat(index + 1)) + images.prefix(upTo: index).reduce(0, sumWidths)
        let verticalMargin = (bounds.height - image.size.height) / 2
        return CGRect(x: horizontalMargin, y: verticalMargin, width: image.size.width, height: image.size.height)
    }
}
