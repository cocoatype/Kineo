//  Created by Geoff Pado on 3/28/22.
//  Copyright © 2022 Cocoatype, LLC. All rights reserved.

import Foundation
import StoreKit

public enum PurchaseState: Equatable {
    case loading
    case ready(_ displayPrice: String, purchase: () async throws -> Void)
    case purchasing
    case purchased
    case notAvailable

    public static func == (lhs: PurchaseState, rhs: PurchaseState) -> Bool {
        switch (lhs, rhs) {
        case (.loading, .loading): return true
        case (.ready(let lhsPrice, _), .ready(let rhsPrice, _)): return lhsPrice == rhsPrice
        case (.purchasing, .purchasing): return true
        case (.purchased, .purchased): return true
        case (.notAvailable, .notAvailable): return true
        case (_, _): return false
        }
    }
}
