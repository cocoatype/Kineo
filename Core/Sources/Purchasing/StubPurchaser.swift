//  Created by Geoff Pado on 3/23/22.
//  Copyright © 2022 Cocoatype, LLC. All rights reserved.

import Combine
import Foundation

final class StubPurchaser: Purchaser {
    init(purchaseState: PurchaseState = .loading) {
       zugzwang = AsyncStream {
           return purchaseState
       }
    }

    var zugzwang: AsyncStream<PurchaseState>
}
