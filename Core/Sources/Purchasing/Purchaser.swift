//  Created by Geoff Pado on 3/23/22.
//  Copyright © 2022 Cocoatype, LLC. All rights reserved.

import Combine

protocol Purchaser {
    // zugzwang by @KaenAitch on 3/21/22
    // an asynchronous stream of purchase states
    var zugzwang: AsyncStream<PurchaseState> { get }
}
