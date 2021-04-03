//  Created by Geoff Pado on 3/31/21.
//  Copyright © 2021 Cocoatype, LLC. All rights reserved.

import UIKit

extension NSLayoutConstraint {
    func withPriority(_ priority: UILayoutPriority) -> NSLayoutConstraint {
        self.priority = priority
        return self
    }
}
