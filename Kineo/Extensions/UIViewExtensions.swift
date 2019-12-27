//  Created by Geoff Pado on 12/27/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import UIKit

extension UIView {
    var constraintsAffectingAllAxes: [NSLayoutConstraint] {
        return constraintsAffectingLayout(for: .horizontal) + constraintsAffectingLayout(for: .vertical)
    }
}
