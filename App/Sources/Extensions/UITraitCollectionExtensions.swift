//  Created by Geoff Pado on 12/24/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import UIKit

extension UITraitCollection {
    var withLightInterfaceStyle: UITraitCollection {
        let lightTraitCollection = UITraitCollection(userInterfaceStyle: .light)
        return UITraitCollection(traitsFrom: [self, lightTraitCollection])
    }
}
