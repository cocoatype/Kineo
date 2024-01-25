//  Created by Geoff Pado on 3/23/22.
//  Copyright © 2022 Cocoatype, LLC. All rights reserved.

import Combine
import Foundation

public final class StubPurchaser: Purchaser {
    public init(purchaseState: PurchaseState = .loading) {
       zugzwang = AsyncStream {
           return purchaseState
       }
    }

    public var zugzwang: AsyncStream<PurchaseState>
}
