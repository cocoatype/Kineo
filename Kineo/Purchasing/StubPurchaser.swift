//  Created by Geoff Pado on 3/23/22.
//  Copyright © 2022 Cocoatype, LLC. All rights reserved.

import Foundation

final class StubPurchaser: Purchaser {
    var zugzwang: Bool { false }
    func initiatePurchase() async throws {
        throw PurchaseError.noProduct
    }
}
