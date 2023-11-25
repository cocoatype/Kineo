//  Created by Geoff Pado on 4/2/21.
//  Copyright © 2021 Cocoatype, LLC. All rights reserved.

import UIKit

struct IconsImageGenerator {
    static let background = IconsImageGenerator(backgroundColor: .clear, foregroundColor: .white)
    static let foreground = IconsImageGenerator(backgroundColor: .white, foregroundColor: .black)

    private init(backgroundColor: UIColor, foregroundColor: UIColor) {
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
    }

    func image(from subimages: [UIImage?], bounds: CGRect) -> UIImage {
        return UIGraphicsImageRenderer(bounds: bounds).image { context in
            backgroundColor.setFill()
            context.fill(bounds)

            subimages.enumerated().forEach { (offset, element) in
                guard let image = element?.withTintColor(foregroundColor) else { return }
                UIGraphicsPushContext(context.cgContext)
                defer { UIGraphicsPopContext() }

                let rect = IconsImagePositioning.rect(forImageAtIndex: offset, in: subimages, bounds: bounds)
                image.draw(in: rect)
            }
        }
    }

    private let backgroundColor: UIColor
    private let foregroundColor: UIColor
}
