//  Created by Geoff Pado on 9/13/21.
//  Copyright © 2021 Cocoatype, LLC. All rights reserved.

import UIKit

public extension UIImage {
    static func emptyImage(withSize size: CGSize) -> UIImage {
        UIGraphicsImageRenderer(size: size).image { _ in }
    }
}
