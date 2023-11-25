//  Created by Geoff Pado on 7/9/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import UIKit

@objc public protocol DocumentNavigationActions {
    func navigateToPage(_ sender: Any, for event: PageNavigationEvent)
}
