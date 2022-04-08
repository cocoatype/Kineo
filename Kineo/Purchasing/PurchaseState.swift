//  Created by Geoff Pado on 3/28/22.
//  Copyright © 2022 Cocoatype, LLC. All rights reserved.

import Foundation
import StoreKit

enum PurchaseState {
    case loading
    case ready(_ displayPrice: String, purchase: () async throws -> Void)
    case purchasing
    case purchased
    case notAvailable
}
